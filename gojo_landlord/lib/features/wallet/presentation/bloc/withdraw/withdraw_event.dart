part of 'withdraw_bloc.dart';

@immutable
abstract class WithdrawEvent {}

class WithdrawConfirmed extends WithdrawEvent {}

class AmountChanged extends WithdrawEvent {
  final String amount;

  AmountChanged({required this.amount});
}

class BankChanged extends WithdrawEvent {
  final String bank;

  BankChanged({required this.bank});
}

class AccountNumberChanged extends WithdrawEvent {
  final String accountNumber;

  AccountNumberChanged({required this.accountNumber});
}
