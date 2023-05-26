import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gojo/core/model/user.dart';
import 'package:gojo/features/auth/register/data/repository/register_repository.dart';
import 'package:gojo/features/auth/signin/presentation/model/password_input.dart';
import 'package:gojo/features/auth/signin/presentation/model/phone_number_input.dart';

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
          status: RegisterFormStatus.editing,
        ),
      );
    });

    on<LastNameChanged>((event, emit) {
      emit(
        state.copyWith(
          lname: NameInput.dirty(value: event.lname),
          status: RegisterFormStatus.editing,
        ),
      );
    });

    on<PhoneChanged>((event, emit) {
      emit(
        state.copyWith(
          phone: PhoneNumberInput.dirty(value: event.phone),
          status: RegisterFormStatus.editing,
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: PasswordInput.dirty(value: event.password),
          status: RegisterFormStatus.editing,
        ),
      );
    });

    on<IDFileChanged>((event, emit) {
      emit(
        state.copyWith(
          idPath: event.path,
          status: RegisterFormStatus.editing,
        ),
      );
    });

    on<AvatarChanged>((event, emit) {
      emit(state.copyWith(
        avatar: event.path,
        status: RegisterFormStatus.editing,
      ));
    });

    on<ConsentChanged>((event, emit) {
      emit(state.copyWith(
        consentConfirmed: !state.consentConfirmed,
      ));
    });

    on<ConfirmedAndSubmitted>((event, emit) async {
      emit(state.copyWith(
        status: RegisterFormStatus.success,
      ));

      try {
        final user = User(
          id: 0,
          firstName: state.fname.value,
          lastName: state.lname.value,
          phoneNumber: state.phone.value,
          profilePicture: state.avatar!,
        );
        await registerRepository.registerUser(
          user: user,
          filePath: state.idPath,
        );
        emit(state.copyWith(
          status: RegisterFormStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: RegisterFormStatus.error,
        ));
      }
    });

    on<SendVerificationCode>((event, emit) {
      emit(state.copyWith(
        status: RegisterFormStatus.verificationInprogress,
      ));
    });

    on<PhoneVerified>((event, emit) {
      emit(state.copyWith(
        status: RegisterFormStatus.verified,
      ));
    });
  }
}
