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
  final String selectedBank;
  final AccountNumberInput accountNumberInput;
  final WithDrawRequestStatus withDrawRequestStatus;

  const WithdrawState({
    required this.amountInput,
    required this.selectedBank,
    required this.accountNumberInput,
    required this.withDrawRequestStatus,
  });

  factory WithdrawState.initial() {
    return WithdrawState(
      amountInput: const AmountInput.pure(),
      accountNumberInput: const AccountNumberInput.pure(),
      selectedBank: Bank.banks[0].name,
      withDrawRequestStatus: WithDrawRequestStatus.initial,
    );
  }

  WithdrawState copyWith({
    AmountInput? amountInput,
    AccountNumberInput? accountNumberInput,
    String? selectedBank,
    WithDrawRequestStatus? withDrawRequestStatus,
  }) {
    return WithdrawState(
      accountNumberInput: accountNumberInput ?? this.accountNumberInput,
      selectedBank: selectedBank ?? this.selectedBank,
      amountInput: amountInput ?? this.amountInput,
      withDrawRequestStatus:
          withDrawRequestStatus ?? this.withDrawRequestStatus,
    );
  }
}
