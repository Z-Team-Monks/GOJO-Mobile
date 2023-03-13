import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/padding.dart';
import 'package:gojo/UI/widgets/chat_bubbles/chat_bubble.dart';
import 'package:gojo/resources/resources.dart';

class GojoSentChatBubble extends StatelessWidget {
  final String content;
  const GojoSentChatBubble({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
          top: GojoPadding.extraSmall,
          bottom: GojoPadding.extraSmall,
          left: GojoPadding.extraLarge,
        ),
        child: ChatBubble(
          content: content,
          contentColor: Resources.gojoColors.primaryContrastColor,
          bubbleColor: Resources.gojoColors.primaryColor,
        ),
      ),
    );
  }
}
