import 'package:formz/formz.dart';

enum PasswordError { empty, invalid }

class Password extends FormzInput<String, PasswordError> {
  const Password.pure({String value = ''}) : super.pure(value);

  const Password.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {
    if (value.isEmpty) {
      return PasswordError.empty;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case PasswordError.empty:
        return "Please enter your password";
      default:
        return "";
    }
  }
}
