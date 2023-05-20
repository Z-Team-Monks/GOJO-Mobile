import 'package:flutter/material.dart';

class VerticalLine extends StatelessWidget {
  const VerticalLine({
    super.key,
    required this.visible,
  });

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Container(
        width: visible ? 1.0 : 0.0,
        height: 16.0,
        color: const Color.fromARGB(90, 255, 255, 255),
      ),
    );
  }
}
