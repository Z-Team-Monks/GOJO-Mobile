import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/borders.dart';
import 'package:gojo/UI/widgets/icon_text.dart';
import 'package:gojo/resources/resources.dart';

class GojoMediaCard extends StatelessWidget {
  final String title;
  final String leftTrailingTitle;
  final List<GojoIconText> iconTexts;
  final Image image;

  GojoMediaCard({
    super.key,
    required this.title,
    required this.leftTrailingTitle,
    required this.iconTexts,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: GojoBorders.rounded(GojoBorderRadiusSize.large),
      child: Column(
        children: [
          image,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    Text(leftTrailingTitle),
                  ],
                ),
                Row(children: iconTexts),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
