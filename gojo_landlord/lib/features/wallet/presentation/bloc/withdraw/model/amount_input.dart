import 'package:formz/formz.dart';

enum AmountError { empty, notNumber }

class AmountInput extends FormzInput<String, AmountError> {
  const AmountInput.pure({String value = ''}) : super.pure(value);

  const AmountInput.dirty({String value = ''}) : super.dirty(value);

  @override
  AmountError? validator(String value) {
    if (value.isEmpty) {
      return AmountError.empty;
    }
    if (double.tryParse(value) == null) {
      return AmountError.notNumber;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case AmountError.empty:
        return "Amount can't be empty!";
      case AmountError.notNumber:
        return "Invalid amount input";
      default:
        return "";
    }
  }
}
