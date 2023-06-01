part of 'withdraw_bloc.dart';

enum WithDrawRequestStatus {
  initial,
  loading,
  success,
  error,
}

@immutable
class WithdrawState {
  final AmountInput amountInput;
  final WithDrawRequestStatus withDrawRequestStatus;

  const WithdrawState({
    required this.amountInput,
    required this.withDrawRequestStatus,
  });

  factory WithdrawState.initial() {
    return const WithdrawState(
      amountInput: AmountInput.pure(),
      withDrawRequestStatus: WithDrawRequestStatus.initial,
    );
  }

  WithdrawState copyWith({
    AmountInput? amountInput,
    WithDrawRequestStatus? withDrawRequestStatus,
  }) {
    return WithdrawState(
      amountInput: amountInput ?? this.amountInput,
      withDrawRequestStatus:
          withDrawRequestStatus ?? this.withDrawRequestStatus,
    );
  }
}
