part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class Authenticate extends SignInEvent {
  final String phoneNumber;
  final String password;

  Authenticate({
    required this.phoneNumber,
    required this.password,
  });
}

class PasswordChanged extends SignInEvent {
  final String password;

  PasswordChanged(this.password);
}

class PhoneNumberChanged extends SignInEvent {
  final String phoneNumber;

  PhoneNumberChanged(this.phoneNumber);
}
