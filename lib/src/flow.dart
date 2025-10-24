import 'dart:async';

import 'package:flutter/material.dart';
import 'models.dart';
import 'theme.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/typing_indicator.dart';
import 'widgets/input_bar.dart';

/// Public widget: plug-and-play registration flow
class ChatRegistrationFlow extends StatefulWidget {
  /// The list of steps/questions to ask; order matters.
  final List<ChatStep> steps;

  /// Invoked when the flow completes. Receives a map of step.id -> value
  final void Function(Map<String, String> result) onCompleted;

  /// Optional callback on each answer
  final void Function(String stepId, String value)? onAnswer;

  /// Theme customization
  final ChatRegTheme theme;

  /// Enables Right-to-Left layout (Arabic, etc.)
  final bool isRtl;

  /// If true, the first prompt appears with typing animation on mount.
  final bool autoStart;

  const ChatRegistrationFlow({
    super.key,
    required this.steps,
    required this.onCompleted,
    this.onAnswer,
    this.theme = const ChatRegTheme(),
    this.isRtl = false,
    this.autoStart = true,
  });

  @override
  State<ChatRegistrationFlow> createState() => _ChatRegistrationFlowState();
}

class _ChatRegistrationFlowState extends State<ChatRegistrationFlow> {
  final List<ChatMessage> _messages = [];
  final Map<String, String> _answers = {};
  int _current = 0; // step index
  bool _botTyping = false;
  final _scrollCtrl = ScrollController();

  ChatStep get _currentStep => widget.steps[_current];

  @override
  void initState() {
    super.initState();
    if (widget.autoStart) _enqueuePrompt();
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  Future<void> _enqueuePrompt() async {
    setState(() => _botTyping = true);
    await Future.delayed(widget.theme.typingDelay);

    final prompt = _currentStep.prompt;
    _messages.add(ChatMessage(
      id: 'p_${_current}_${DateTime.now().microsecondsSinceEpoch}',
      sender: ChatSender.bot,
      text: prompt,
      timestamp: DateTime.now(),
    ));

    setState(() => _botTyping = false);
    _scrollToEnd();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollCtrl.hasClients) return;
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  String? _defaultValidate(ChatStep step, String value) {
    value = value.trim();
    if (value.isEmpty) return 'Required';
    switch (step.type) {
      case ChatInputType.email:
        final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
        return ok ? null : 'Enter a valid email';
      /*case ChatInputType.number:
        final ok = RegExp(r'^\d{6,15}\$').hasMatch(value); // mobile number heuristic
        return ok ? null : 'Enter a valid number';*/
      default:
        return null;
    }
  }

  Future<void> _handleSubmit(String value) async {
    final step = _currentStep;
    final v = step.validator?.call(value) ?? _defaultValidate(step, value);
    if (v != null) {
      // Show inline error as a bot message for conversational UX
      _messages.add(ChatMessage(
        id: 'e_${_current}_${DateTime.now().microsecondsSinceEpoch}',
        sender: ChatSender.bot,
        text: v,
        timestamp: DateTime.now(),
      ));
      setState(() {});
      _scrollToEnd();
      return;
    }

    // Append user message
    _answers[step.id] = value.trim();
    _messages.add(ChatMessage(
      id: 'u_${_current}_${DateTime.now().microsecondsSinceEpoch}',
      sender: ChatSender.user,
      text: value.trim(),
      timestamp: DateTime.now(),
    ));
    widget.onAnswer?.call(step.id, value.trim());

    setState(() {});
    _scrollToEnd();

    // Optional per-step hook
    if (step.onSubmitted != null) await step.onSubmitted!(value.trim());

    // Next step or complete
    if (_current < widget.steps.length - 1) {
      _current += 1;
      await Future.delayed(widget.theme.stepDelay);
      await _enqueuePrompt();
    } else {
      await Future.delayed(widget.theme.typingDelay);
      // Final confirmation message
      _messages.add(ChatMessage(
        id: 'done_${DateTime.now().microsecondsSinceEpoch}',
        sender: ChatSender.bot,
        text: 'Your registration has been completed. ✅',
        timestamp: DateTime.now(),
      ));
      setState(() {});
      _scrollToEnd();
      widget.onCompleted(Map.of(_answers));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;

    return DecoratedBox(
      decoration: BoxDecoration(color: t.backgroundColor),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: t.chatPadding,
                child: ListView.separated(
                  controller: _scrollCtrl,
                  itemCount: _messages.length + (_botTyping ? 1 : 0),
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    if (_botTyping && index == _messages.length) {
                      return Align(
                        alignment: widget.isRtl
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: t.botBubbleColor,
                            borderRadius: t.bubbleRadius,
                          ),
                          child: const TypingIndicator(),
                        ),
                      );
                    }

                    final m = _messages[index];
                    return ChatBubble(
                        message: m, theme: t, isRtl: widget.isRtl);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: InputBar(
                step: _currentStep,
                theme: t,
                isRtl: widget.isRtl,
                onSubmit: _handleSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
