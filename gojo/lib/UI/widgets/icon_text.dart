import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData iconData;
  final String title;

  const IconText({super.key, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }
}
