import 'package:flutter/material.dart';
import 'package:gojo/UI/widgets/icon_text.dart';
import 'package:gojo/resources/resources.dart';

class GojoMediaCard extends StatelessWidget {
  final String title;
  final List<GojoIconText> iconTexts;

  GojoMediaCard({super.key, required this.title, required this.iconTexts});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image(
            image: AssetImage(Resources.gojoImages.sofaSaloon),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title),
                    Row(children: iconTexts),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
