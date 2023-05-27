import 'package:flutter/material.dart';

class FormInputLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  const FormInputLabel(
      {super.key, required this.label, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 1),
          Visibility(
            visible: isRequired,
            child: const Icon(
              Icons.star,
              size: 10,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
