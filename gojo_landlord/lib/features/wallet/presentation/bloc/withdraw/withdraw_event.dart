part of 'withdraw_bloc.dart';

@immutable
abstract class WithdrawEvent {}

class WithdrawConfirmed extends WithdrawEvent {}

class AmountChanged extends WithdrawEvent {
  final String amount;

  AmountChanged({required this.amount});
}
