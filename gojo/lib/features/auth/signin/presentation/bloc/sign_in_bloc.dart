import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../data_layer/repository/sign_in_repository.dart';
import '../model/password_input.dart';
import '../model/phone_number_input.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepositoryAPI signInRepository;
  final UserRepositoryAPI userRepository;

  SignInBloc({
    required this.signInRepository,
    required this.userRepository,
  }) : super(SignInState.initial()) {
    on<PhoneNumberChanged>((event, emit) {
      final phoneNumber = PhoneNumberInput.dirty(value: event.phoneNumber);
      emit(
        state.copyWith(
          phoneNumber: phoneNumber,
          status: SignInRequestStatus.editing,
          errorMessage: null,
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      final password = PasswordInput.dirty(value: event.password);
      emit(
        state.copyWith(
          password: password,
          status: SignInRequestStatus.editing,
          errorMessage: null,
        ),
      );
    });

    on<Authenticate>((event, emit) async {
      emit(state.copyWith(
        status: SignInRequestStatus.loading,
        errorMessage: null,
      ));

      final authenticationValue = await signInRepository.authenticate(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );

      await authenticationValue.fold(
        (user) async {
          await userRepository.persistUser(user);
          emit(state.copyWith(
            status: SignInRequestStatus.success,
            errorMessage: null,
          ));
        },
        (error) {
          emit(
            state.copyWith(
                status: SignInRequestStatus.error,
                errorMessage: error.toString().replaceFirst('Exception: ', '')),
          );
        },
      );
    });
  }
}
