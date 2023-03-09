import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/borders.dart';
import 'package:gojo/resources/resources.dart';

class GojoTextField extends StatelessWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final String? hintText;
  final bool isObscure;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? Function(String?)? customValidator;

  const GojoTextField({
    Key? key,
    this.labelText,
    this.onChanged,
    this.hintText,
    this.validator,
    this.errorText,
    this.isObscure = false,
    this.customValidator,
    this.initialValue,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        focusedBorder: GojoBorders.rounded(
          GojoBorderRadiusSize.medium,
          borderSide: BorderSide(
            color: Resources.gojoColors.primaryColor,
            width: 0.5,
          ),
        ),
        filled: true,
        border: GojoBorders.rounded(GojoBorderRadiusSize.medium),
        hintText: hintText,
        labelText: labelText,
      ),
      obscureText: isObscure,
    );
  }
}
