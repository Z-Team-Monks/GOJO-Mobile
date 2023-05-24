import 'package:formz/formz.dart';

enum TitleError { empty, invalid }

class TitleInput extends FormzInput<String, TitleError> {
  const TitleInput.pure({String value = ''}) : super.pure(value);

  const TitleInput.dirty({String value = ''}) : super.dirty(value);

  @override
  TitleError? validator(String value) {
    if (value.isEmpty) {
      return TitleError.empty;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case TitleError.empty:
        return "Title can't be empty!";
      default:
        return "";
    }
  }
}
