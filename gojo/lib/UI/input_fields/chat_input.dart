import 'package:flutter/material.dart';
import 'package:gojo/UI/input_fields/text_field.dart';
import 'package:gojo/resources/resources.dart';

class GojoChatInput extends StatelessWidget {
  final String label;
  final Function() onSendIconPressed;

  const GojoChatInput({
    required this.label,
    required this.onSendIconPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GojoTextField(
          hintText: label,
          maxLines: null,
          suffixIcon: InkWell(
            onTap: onSendIconPressed,
            child: Icon(
              Icons.send,
              color: Resources.gojoColors.black,
            ),
          ),
          onChanged: ((value) {}),
        ),
      ],
    );
  }
}
