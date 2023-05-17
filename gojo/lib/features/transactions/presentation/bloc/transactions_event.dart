part of 'transactions_bloc.dart';

@immutable
abstract class TransactionsEvent {}

class LoadTransactions extends TransactionsEvent {}
