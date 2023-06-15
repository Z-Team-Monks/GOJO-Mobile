import 'package:bloc/bloc.dart';
import 'package:gojo/features/auth/signin/data_layer/repository/sign_in_repository.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final String phoneNumber;
  final SignInRepositoryAPI signInRepository;

  ForgotPasswordBloc({
    required this.phoneNumber,
    required this.signInRepository,
  }) : super(ForgotPasswordState.initial()) {
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
      ));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          confirmPassword: event.confirmPassword,
        ),
      );
    });

    on<ResetSubmitted>((event, emit) async {
      emit(state.copyWith(status: ForgotPasswordStatus.loading));
      final result = await signInRepository.forgotPassword(
        phoneNumber: phoneNumber,
        newPassword: state.password,
      );

      result.fold(
        (success) {
          emit(state.copyWith(status: ForgotPasswordStatus.success));
        },
        (failure) {
          emit(state.copyWith(status: ForgotPasswordStatus.error));
        },
      );
    });
  }
}
