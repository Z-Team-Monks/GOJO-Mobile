import 'package:formz/formz.dart';

enum DescriptionError { empty, invalid }

class DescriptionInput extends FormzInput<String, DescriptionError> {
  const DescriptionInput.pure({String value = ''}) : super.pure(value);

  const DescriptionInput.dirty({String value = ''}) : super.dirty(value);

  @override
  DescriptionError? validator(String value) {
    if (value.isEmpty) {
      return DescriptionError.empty;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case DescriptionError.empty:
        return "Description can't be empty!";
      default:
        return "";
    }
  }
}
