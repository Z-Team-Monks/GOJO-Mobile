import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/padding.dart';
import 'package:gojo/UI/widgets/chat_bubbles/chat_bubble.dart';
import 'package:gojo/resources/resources.dart';

class GojoReceivedChatBubble extends StatelessWidget {
  final ImageProvider<Object> image;
  final String content;

  const GojoReceivedChatBubble({
    super.key,
    required this.image,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: GojoPadding.extraSmall,
        bottom: GojoPadding.extraSmall,
        right: GojoPadding.extraLarge,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: image,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: ChatBubble(
                content: content,
                contentColor: Resources.gojoColors.black,
                bubbleColor: Resources.gojoColors.lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
