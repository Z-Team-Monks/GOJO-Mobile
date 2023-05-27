import 'package:formz/formz.dart';

import '../../data_layer/model/address.dart';

enum AddressError { empty }

class AddressInput extends FormzInput<Address?, AddressError> {
  const AddressInput.pure({Address? value}) : super.pure(value);

  const AddressInput.dirty({Address? value}) : super.dirty(value);

  @override
  AddressError? validator(Address? value) {
    if (value == null) {
      return AddressError.empty;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case AddressError.empty:
        return "Address can't be empty!";
      default:
        return "";
    }
  }
}
