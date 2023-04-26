import 'package:formz/formz.dart';

enum MessageInputError { empty }

class MessageInput extends FormzInput<String, MessageInputError> {
  // Call super.pure to represent an unmodified form input.
  const MessageInput.pure({String value = ''}) : super.pure(value);

  // Call super.dirty to represent a modified form input.
  const MessageInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  MessageInputError? validator(String value) {
    if (value.isEmpty) {
      return MessageInputError.empty;
    }
    return null;
  }

  String getErrorMessage() {
    switch (displayError) {
      case MessageInputError.empty:
        return "Review message can't be empty!";
      default:
        return "";
    }
  }
}
