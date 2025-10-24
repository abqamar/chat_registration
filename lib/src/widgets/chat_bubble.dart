import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final ChatRegTheme theme;
  final bool isRtl;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.theme,
      this.isRtl = false});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == ChatSender.user;
    final bubbleColor = isUser ? theme.userBubbleColor : theme.botBubbleColor;
    final textColor = isUser ? theme.userTextColor : theme.botTextColor;

    final align = isUser
        ? (isRtl ? Alignment.centerLeft : Alignment.centerRight)
        : (isRtl ? Alignment.centerRight : Alignment.centerLeft);

    final rowChildren = <Widget>[
      if (theme.showAvatars && !isUser && theme.botAvatar != null) ...[
        theme.botAvatar!,
        const SizedBox(width: 8),
      ],
      Flexible(
        child: Container(
          padding: theme.bubblePadding,
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: theme.bubbleRadius,
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor).merge(theme.promptTextStyle),
          ),
        ),
      ),
      if (theme.showAvatars && isUser && theme.userAvatar != null) ...[
        const SizedBox(width: 8),
        theme.userAvatar!,
      ],
    ];

    return Align(
      alignment: align,
      child: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: isUser ? rowChildren.reversed.toList() : rowChildren,
        ),
      ),
    );
  }
}
