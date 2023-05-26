import 'dart:math';

import 'package:flutter/material.dart';

class PickAFileButton extends StatelessWidget {
  final String? path;
  const PickAFileButton({
    super.key,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFD5D5D5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.photo_library,
              color: Color.fromARGB(150, 27, 181, 92),
            ),
            const SizedBox(width: 15),
            Text(
              path != null
                  ? path!.substring(max(path!.length - 12, 0))
                  : "Pick Image",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
