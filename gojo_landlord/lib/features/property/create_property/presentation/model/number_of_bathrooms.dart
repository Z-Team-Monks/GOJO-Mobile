import 'package:formz/formz.dart';

enum NumberOfBathroomsError { empty, invalid, notNumber }

class NumberOfBathroomsInput
    extends FormzInput<String, NumberOfBathroomsError> {
  const NumberOfBathroomsInput.pure({String value = ''}) : super.pure(value);

  const NumberOfBathroomsInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NumberOfBathroomsError? validator(String value) {
    if (value.isEmpty) {
      return NumberOfBathroomsError.empty;
    }
    if (double.tryParse(value) == null) {
      return NumberOfBathroomsError.notNumber;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case NumberOfBathroomsError.empty:
        return "Number of bathrooms can't be empty!";
      case NumberOfBathroomsError.notNumber:
        return "Invalid number of bathrooms input";
      default:
        return "";
    }
  }
}
