import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/padding.dart';

class ChatBubble extends StatelessWidget {
  final String content;
  final Color? contentColor;
  final Color? bubbleColor;

  const ChatBubble({
    super.key,
    required this.content,
    required this.contentColor,
    required this.bubbleColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(GojoPadding.medium),
        child: Text(
          content,
          style: TextStyle(
            color: contentColor,
          ),
        ),
      ),
    );
  }
}
