import 'package:flutter/material.dart';

class GojoTextButton extends StatelessWidget {
  final void Function() onPressed;
  final Color color;
  final String label;

  const GojoTextButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: color),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(color: color),
      ),
    );
  }
}
