part of 'otp_bloc.dart';

enum OtpStatus {
  init,
  sending,
  codeSent,
  inprogress,
  success,
  error,
}

class OtpState extends Equatable {
  final OtpStatus status;
  final String otpCode;
  final PhoneNumberInput phone;

  const OtpState({
    this.status = OtpStatus.init,
    this.otpCode = "",
    this.phone = const PhoneNumberInput.pure(),
  });

  copyWith({
    OtpStatus? status,
    String? otpCode,
    PhoneNumberInput? phone,
  }) {
    return OtpState(
      status: status ?? this.status,
      otpCode: otpCode ?? this.otpCode,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [
        status,
        otpCode,
        phone,
      ];
}
