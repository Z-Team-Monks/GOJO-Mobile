import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/padding.dart';
import 'package:gojo/resources/resources.dart';

class GojoContentItem extends StatelessWidget {
  final ImageProvider<Object> image;
  final String title;
  final String content;
  final String rightAlignedTitle;
  final String rightAlignedContent;

  const GojoContentItem({
    super.key,
    required this.image,
    required this.title,
    required this.content,
    required this.rightAlignedTitle,
    required this.rightAlignedContent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CircleAvatar(
            radius: 35,
            backgroundImage: image,
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: GojoPadding.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(rightAlignedTitle),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Resources.gojoColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Resources.gojoColors.primaryColor,
                        spreadRadius: 0),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: GojoPadding.extraSmall,
                  horizontal: GojoPadding.small,
                ),
                child: Text(
                  rightAlignedContent,
                  style: TextStyle(
                    color: Resources.gojoColors.primaryContrastColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
