import 'package:formz/formz.dart';

enum SqaureAreaError { empty, invalid }

class SqaureAreaInput extends FormzInput<String, SqaureAreaError> {
  const SqaureAreaInput.pure({String value = ''}) : super.pure(value);

  const SqaureAreaInput.dirty({String value = ''}) : super.dirty(value);

  @override
  SqaureAreaError? validator(String value) {
    if (value.isEmpty) {
      return SqaureAreaError.empty;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case SqaureAreaError.empty:
        return "Sqaure area can't be empty!";
      default:
        return "";
    }
  }
}
