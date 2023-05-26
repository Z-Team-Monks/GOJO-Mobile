part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {}

class SetPhone extends OtpEvent {
  final String phone;
  SetPhone({required this.phone});

  @override
  List<Object> get props => [phone];
}

class ResendVerificationCode extends OtpEvent {
  @override
  List<Object> get props => [];
}

class VerifcationSubmitted extends OtpEvent {
  VerifcationSubmitted();

  @override
  List<Object> get props => [];
}

class OTPCodeChanged extends OtpEvent {
  final String otp;
  OTPCodeChanged({required this.otp});
  @override
  List<Object> get props => [otp];
}
