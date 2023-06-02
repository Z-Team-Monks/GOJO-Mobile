import 'package:formz/formz.dart';

enum AccountNumberError { empty }

class AccountNumberInput extends FormzInput<String, AccountNumberError> {
  const AccountNumberInput.pure({String value = ''}) : super.pure(value);

  const AccountNumberInput.dirty({String value = ''}) : super.dirty(value);

  @override
  AccountNumberError? validator(String value) {
    if (value.isEmpty) {
      return AccountNumberError.empty;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case AccountNumberError.empty:
        return "Bank account number can't be empty!";
      default:
        return "";
    }
  }
}
