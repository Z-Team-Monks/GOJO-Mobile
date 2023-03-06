import 'package:flutter/material.dart';
import 'package:gojo/UI/widgets/icon_text.dart';
import 'package:gojo/resources/resources.dart';

class MediaCard extends StatelessWidget {
  final String title;
  final List<IconText> iconTexts;

  MediaCard({super.key, required this.title, required this.iconTexts});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image(  
            image: AssetImage(Resources.appImages.sofaSaloon),
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
