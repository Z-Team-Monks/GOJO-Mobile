part of 'transactions_bloc.dart';

@immutable
abstract class TransactionsEvent {}

class LoadTransactions extends TransactionsEvent {}

class ResetTransactionsBloc extends TransactionsEvent {}

class PayNowClicked extends TransactionsEvent {
  final int transactionId;
  PayNowClicked(this.transactionId);
}
