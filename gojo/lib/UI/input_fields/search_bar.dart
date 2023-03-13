import 'package:flutter/material.dart';
import 'package:gojo/UI/input_fields/text_field.dart';

class GojoSearchBar extends StatelessWidget {
  final String label;
  final Widget? suffixIcon;

  const GojoSearchBar({
    required this.label,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GojoTextField(
        hintText: label,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: suffixIcon,
        onChanged: ((value) {}),
      ),
    );
  }
}
