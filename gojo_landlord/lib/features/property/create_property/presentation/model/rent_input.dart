import 'package:formz/formz.dart';

enum RentError { empty, notNumber }

class RentInput extends FormzInput<String, RentError> {
  const RentInput.pure({String value = ''}) : super.pure(value);

  const RentInput.dirty({String value = ''}) : super.dirty(value);

  @override
  RentError? validator(String value) {
    if (value.isEmpty) {
      return RentError.empty;
    }
    if (double.tryParse(value) == null) {
      return RentError.notNumber;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case RentError.empty:
        return "Rent can't be empty!";
      case RentError.notNumber:
        return "Invalid rent input";
      default:
        return "";
    }
  }
}
