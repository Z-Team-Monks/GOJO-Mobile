part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus { initial, loading, success, error }

@immutable
class ForgotPasswordState {
  final String password;
  final String? passwordError;
  final String confirmPassword;
  final String? confirmPasswordError;
  final ForgotPasswordStatus status;

  const ForgotPasswordState({
    required this.password,
    this.passwordError,
    required this.confirmPassword,
    this.confirmPasswordError,
    required this.status,
  });

  ForgotPasswordState copyWith({
    String? password,
    String? confirmPassword,
    ForgotPasswordStatus? status,
  }) {
    return ForgotPasswordState(
      password: password ?? this.password,
      passwordError: _getPasswordError(password ?? this.password),
      confirmPassword: confirmPassword ?? this.confirmPassword,
      confirmPasswordError: _getConfirmPasswordError(
        confirmPassword ?? this.confirmPassword,
        password ?? this.password,
      ),
      status: status ?? this.status,
    );
  }

  static ForgotPasswordState initial() {
    return const ForgotPasswordState(
      password: '',
      passwordError: null,
      confirmPassword: '',
      confirmPasswordError: null,
      status: ForgotPasswordStatus.initial,
    );
  }

  String? _getPasswordError(String password) {
    if (password.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  String? _getConfirmPasswordError(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return "Confirm Password is required";
    } else if (confirmPassword != password) {
      return "Password and Confirm password must be same";
    }
    return null;
  }
}
