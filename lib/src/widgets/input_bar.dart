import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models.dart';
import '../theme.dart';

class InputBar extends StatefulWidget {
  final ChatStep step;
  final ChatRegTheme theme;
  final bool isRtl;
  final void Function(String value) onSubmit;

  const InputBar(
      {super.key,
      required this.step,
      required this.theme,
      required this.onSubmit,
      this.isRtl = false});

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.step.initialValue ?? '');
  }

  @override
  void didUpdateWidget(covariant InputBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step.id != widget.step.id) {
      _controller.text = widget.step.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleDobPick() async {
    final now = DateTime.now();
    final initialDate = DateTime(now.year - 18, now.month, now.day);
    final firstDate = DateTime(now.year - 100);
    final lastDate = now;
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      _controller.text = date.toIso8601String().split('T').first; // YYYY-MM-DD
      setState(() {});
    }
  }

  TextInputType _keyboardFor(ChatInputType t) {
    switch (t) {
      case ChatInputType.number:
        return TextInputType.number;
      case ChatInputType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;
    final step = widget.step;

    final decoration = step.inputDecoration ??
        t.inputDecoration.copyWith(hintText: step.hintText);
    final kb = step.keyboardType ?? _keyboardFor(step.type);

    final textField = Expanded(
      child: TextField(
        controller: _controller,
        keyboardType: kb,
        style: t.inputTextStyle,
        decoration: decoration,
        onSubmitted: (_) => widget.onSubmit(_controller.text.trim()),
        readOnly: step.type == ChatInputType.dob,
        onTap: step.type == ChatInputType.dob ? _handleDobPick : null,
      ),
    );

    final sendBtn = ElevatedButton(
      style: t.sendButtonStyle,
      onPressed: () => widget.onSubmit(_controller.text.trim()),
      child: t.sendIcon ?? const Icon(Icons.send),
    );

    return Directionality(
      textDirection: widget.isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Row(
        children: [textField, const SizedBox(width: 8), sendBtn],
      ),
    );
  }
}
