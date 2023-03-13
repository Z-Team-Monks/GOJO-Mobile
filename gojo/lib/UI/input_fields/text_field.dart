import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/borders.dart';
import 'package:gojo/resources/resources.dart';

class GojoTextField extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isObscure;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final String? Function(String?)? customValidator;

  const GojoTextField({
    Key? key,
    this.labelText,
    this.initialValue,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.validator,
    this.customValidator,
    this.isObscure = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
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
