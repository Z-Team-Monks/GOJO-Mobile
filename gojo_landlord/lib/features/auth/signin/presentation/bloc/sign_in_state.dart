part of 'sign_in_bloc.dart';

enum SignInRequestStatus { initial, editing, loading, success, error }

class SignInState extends Equatable {
  final SignInRequestStatus status;
  final PasswordInput password;
  final PhoneNumberInput phoneNumber;
  final String? errorMessage;

  SignInState({
    required this.status,
    required this.password,
    required this.phoneNumber,
    required this.errorMessage,
  }) {
    // It avoids setting errorMessage to null when status is an error.
    assert(status != SignInRequestStatus.error || errorMessage != null,
        'errorMessage must not be null when status is error');

    // It avoids setting errorMessage to string  when status is not
    // an error. This is not a duplicate of the above assert.
    assert(status == SignInRequestStatus.error || errorMessage == null,
        'errorMessage must have content when status is not error');
  }

  SignInState copyWith({
    SignInRequestStatus? status,
    PasswordInput? password,
    PhoneNumberInput? phoneNumber,
    String? errorMessage,
  }) {
    return SignInState(
      status: status ?? this.status,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorMessage: errorMessage,
    );
  }

  factory SignInState.initial() {
    return SignInState(
      status: SignInRequestStatus.initial,
      password: const PasswordInput.pure(),
      phoneNumber: const PhoneNumberInput.pure(),
      errorMessage: null,
    );
  }

  @override
  List<Object?> get props => [
        status,
        password,
        phoneNumber,
        errorMessage,
      ];
}
