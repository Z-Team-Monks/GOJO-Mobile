import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../register/data/repository/register_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final RegisterRepository registerRepository;

  OtpBloc({required this.registerRepository}) : super(const OtpState()) {
    on<OTPCodeChanged>((event, emit) {
      emit(state.copyWith(otpCode: event.otp));
    });

    on<SetPhone>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });

    on<ResendVerificationCode>((event, emit) async {
      emit(state.copyWith(
        status: OtpStatus.inprogress,
      ));

      try {
        await registerRepository.sendOtp(phone: state.phone);

        emit(state.copyWith(status: OtpStatus.codeSent));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          status: OtpStatus.error,
        ));
      }
    });

    on<VerifcationSubmitted>((event, emit) async {
      emit(state.copyWith(
        status: OtpStatus.inprogress,
      ));

      try {
        await registerRepository.verifyUser(
          phone: state.phone,
          otpCode: state.otpCode,
        );
        emit(state.copyWith(
          status: OtpStatus.success,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          status: OtpStatus.error,
        ));
      }
    });
  }
}
