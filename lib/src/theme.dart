import 'package:flutter/material.dart';

class ChatRegTheme {
  final Color backgroundColor;
  final Color botBubbleColor;
  final Color userBubbleColor;
  final Color botTextColor;
  final Color userTextColor;
  final TextStyle? promptTextStyle;
  final TextStyle? inputTextStyle;
  final InputDecoration inputDecoration;
  final ButtonStyle sendButtonStyle;
  final Widget? sendIcon;
  final Duration typingDelay; // delay before bot replies
  final Duration stepDelay; // delay before next prompt appears
  final BorderRadius bubbleRadius;
  final EdgeInsets bubblePadding;
  final EdgeInsets chatPadding;
  final bool showAvatars;
  final Widget? botAvatar;
  final Widget? userAvatar;

  const ChatRegTheme({
    this.backgroundColor = const Color(0xFFF6F6F6),
    this.botBubbleColor = const Color(0xFFE9EEF7),
    this.userBubbleColor = const Color(0xFFDCF7C5),
    this.botTextColor = const Color(0xFF0F172A),
    this.userTextColor = const Color(0xFF0F172A),
    this.promptTextStyle,
    this.inputTextStyle,
    this.inputDecoration = const InputDecoration(
      border: OutlineInputBorder(),
      isDense: true,
    ),
    this.sendButtonStyle = const ButtonStyle(),
    this.sendIcon,
    this.typingDelay = const Duration(milliseconds: 700),
    this.stepDelay = const Duration(milliseconds: 300),
    this.bubbleRadius = const BorderRadius.all(Radius.circular(16)),
    this.bubblePadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.chatPadding = const EdgeInsets.fromLTRB(12, 12, 12, 8),
    this.showAvatars = false,
    this.botAvatar,
    this.userAvatar,
  });

  ChatRegTheme copyWith({
    Color? backgroundColor,
    Color? botBubbleColor,
    Color? userBubbleColor,
    Color? botTextColor,
    Color? userTextColor,
    TextStyle? promptTextStyle,
    TextStyle? inputTextStyle,
    InputDecoration? inputDecoration,
    ButtonStyle? sendButtonStyle,
    Widget? sendIcon,
    Duration? typingDelay,
    Duration? stepDelay,
    BorderRadius? bubbleRadius,
    EdgeInsets? bubblePadding,
    EdgeInsets? chatPadding,
    bool? showAvatars,
    Widget? botAvatar,
    Widget? userAvatar,
  }) {
    return ChatRegTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      botBubbleColor: botBubbleColor ?? this.botBubbleColor,
      userBubbleColor: userBubbleColor ?? this.userBubbleColor,
      botTextColor: botTextColor ?? this.botTextColor,
      userTextColor: userTextColor ?? this.userTextColor,
      promptTextStyle: promptTextStyle ?? this.promptTextStyle,
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      inputDecoration: inputDecoration ?? this.inputDecoration,
      sendButtonStyle: sendButtonStyle ?? this.sendButtonStyle,
      sendIcon: sendIcon ?? this.sendIcon,
      typingDelay: typingDelay ?? this.typingDelay,
      stepDelay: stepDelay ?? this.stepDelay,
      bubbleRadius: bubbleRadius ?? this.bubbleRadius,
      bubblePadding: bubblePadding ?? this.bubblePadding,
      chatPadding: chatPadding ?? this.chatPadding,
      showAvatars: showAvatars ?? this.showAvatars,
      botAvatar: botAvatar ?? this.botAvatar,
      userAvatar: userAvatar ?? this.userAvatar,
    );
  }
}
