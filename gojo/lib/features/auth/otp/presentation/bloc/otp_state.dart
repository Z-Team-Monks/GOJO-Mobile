part of 'otp_bloc.dart';

enum OtpStatus {
  sending,
  codeSent,
  inprogress,
  success,
  error,
}

class OtpState extends Equatable {
  final OtpStatus status;
  final String otpCode;
  final String phone;

  const OtpState({
    this.status = OtpStatus.sending,
    this.otpCode = "",
    this.phone = "",
  });

  copyWith({
    OtpStatus? status,
    String? otpCode,
    String? phone,
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
