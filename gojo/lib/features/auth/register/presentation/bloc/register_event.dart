part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {}

class FirstNameChanged extends RegisterEvent {
  final String fname;

  FirstNameChanged({required this.fname});

  @override
  List<Object> get props => [fname];
}

class LastNameChanged extends RegisterEvent {
  final String lname;

  LastNameChanged({required this.lname});

  @override
  List<Object> get props => [lname];
}

class PhoneChanged extends RegisterEvent {
  final String phone;

  PhoneChanged({required this.phone});

  @override
  List<Object> get props => [phone];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class IDFileChanged extends RegisterEvent {
  final String path;

  IDFileChanged({required this.path});

  @override
  List<Object> get props => [path];
}

class AvatarChanged extends RegisterEvent {
  final String path;

  AvatarChanged({required this.path});

  @override
  List<Object> get props => [path];
}

class ConfirmedAndSubmitted extends RegisterEvent {
  ConfirmedAndSubmitted();
  @override
  List<Object> get props => [];
}

class SendVerificationCode extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class PhoneVerified extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class ConsentChanged extends RegisterEvent {
  @override
  List<Object> get props => [];
}
