import 'package:formz/formz.dart';

enum SquareAreaError { empty, notNumber }

class SquareAreaInput extends FormzInput<String, SquareAreaError> {
  const SquareAreaInput.pure({String value = ''}) : super.pure(value);

  const SquareAreaInput.dirty({String value = ''}) : super.dirty(value);

  @override
  SquareAreaError? validator(String value) {
    if (value.isEmpty) {
      return SquareAreaError.empty;
    }
    if (double.tryParse(value) == null) {
      return SquareAreaError.notNumber;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case SquareAreaError.empty:
        return "Square area can't be empty!";
      case SquareAreaError.notNumber:
        return "Invalid square area input";
      default:
        return "";
    }
  }
}
