import 'package:flutter/material.dart';
import 'package:gojo/resources/resources.dart';

class TextLink extends StatelessWidget {
  final String label;
  final Function() onClick;

  const TextLink({
    super.key,
    required this.label,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(color: Resources.gojoColors.primaryColor),
    );
  }
}
