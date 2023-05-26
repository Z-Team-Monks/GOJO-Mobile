import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../signin/presentation/model/password_input.dart';
import '../../../signin/presentation/model/phone_number_input.dart';
import '../../data/models/user_reg_model.dart';
import '../../data/repository/register_repository.dart';
import '../value_objects/name_input.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc({required this.registerRepository})
      : super(const RegisterState()) {
    on<FirstNameChanged>((event, emit) {
      emit(
        state.copyWith(
          fname: NameInput.dirty(value: event.fname),
          formStatus: RegisterFormStatus.editing,
        ),
      );
    });

    on<LastNameChanged>((event, emit) {
      emit(
        state.copyWith(
          lname: NameInput.dirty(value: event.lname),
          formStatus: RegisterFormStatus.editing,
        ),
      );
    });

    on<PhoneChanged>((event, emit) {
      emit(
        state.copyWith(
          phone: PhoneNumberInput.dirty(value: event.phone),
          formStatus: RegisterFormStatus.editing,
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: PasswordInput.dirty(value: event.password),
          formStatus: RegisterFormStatus.editing,
        ),
      );
    });

    on<IDFileChanged>((event, emit) {
      emit(
        state.copyWith(
          idPath: event.path,
          formStatus: RegisterFormStatus.editing,
        ),
      );
    });

    on<AvatarChanged>((event, emit) {
      emit(state.copyWith(
        avatar: event.path,
        formStatus: RegisterFormStatus.editing,
      ));
    });

    on<ConsentChanged>((event, emit) {
      emit(state.copyWith(
        consentConfirmed: !state.consentConfirmed,
      ));
    });

    on<ConfirmedAndSubmitted>((event, emit) async {
      emit(state.copyWith(
        formStatus: RegisterFormStatus.inprogress,
      ));

      try {
        final user = UserRegistrationModel(
          firstName: state.fname.value,
          lastName: state.lname.value,
          phoneNumber: state.phone.value,
          profilePicture: state.avatar,
          password: state.password.value,
          identification: state.idPath!,
        );

        await registerRepository.registerUser(user: user);
        emit(state.copyWith(
          formStatus: RegisterFormStatus.success,
        ));
        debugPrint("User Registered!!");
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          formStatus: RegisterFormStatus.error,
        ));
      }
    });
  }
}
