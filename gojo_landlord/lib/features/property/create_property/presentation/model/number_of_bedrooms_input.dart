import 'package:formz/formz.dart';

enum NumberOfBedRoomsError { empty, invalid, notNumber }

class NumberOfBedRoomsInput extends FormzInput<String, NumberOfBedRoomsError> {
  const NumberOfBedRoomsInput.pure({String value = ''}) : super.pure(value);

  const NumberOfBedRoomsInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NumberOfBedRoomsError? validator(String value) {
    if (value.isEmpty) {
      return NumberOfBedRoomsError.empty;
    }
    if (double.tryParse(value) == null) {
      return NumberOfBedRoomsError.notNumber;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case NumberOfBedRoomsError.empty:
        return "Number of bedrooms can't be empty!";
      case NumberOfBedRoomsError.notNumber:
        return "Invalid number of bedrooms input";
      default:
        return "";
    }
  }
}
