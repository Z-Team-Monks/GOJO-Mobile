import 'package:formz/formz.dart';

enum PhoneNumberError { empty, invalid }

class PhoneNumberInput extends FormzInput<String, PhoneNumberError> {
  const PhoneNumberInput.pure({String value = ''}) : super.pure(value);

  const PhoneNumberInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  PhoneNumberError? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberError.empty;
    }
    if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
      return PhoneNumberError.invalid;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case PhoneNumberError.empty:
        return "Please enter a phone number";
      case PhoneNumberError.invalid:
        return "Please enter a valid phone number";
      default:
        return "";
    }
  }
}
