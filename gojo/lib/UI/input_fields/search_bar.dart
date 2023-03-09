import 'package:flutter/material.dart';
import 'package:gojo/UI/input_fields/text_field.dart';

class GojoSearchBar extends StatelessWidget {
  final String label;
  final Function()? onFilterIconPressed;

  const GojoSearchBar({
    required this.label,
    this.onFilterIconPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GojoTextField(
          hintText: label,
          prefixIcon: const Icon(Icons.search),
          onChanged: ((value) {}),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: InkWell(
            onTap: onFilterIconPressed,
            child: const Icon(
              Icons.tune,
            ),
          ),
        )
      ],
    );
  }
}
