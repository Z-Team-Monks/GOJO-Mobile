part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class PasswordChanged extends ForgotPasswordEvent {
  final String password;

  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends ForgotPasswordEvent {
  final String confirmPassword;

  ConfirmPasswordChanged(this.confirmPassword);
}

class ResetSubmitted extends ForgotPasswordEvent {}
