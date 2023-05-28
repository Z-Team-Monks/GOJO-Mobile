part of 'transactions_bloc.dart';

enum FetchTransactionStatus { loading, loaded, error }

enum PaymentWithChapaStatus {
  intial,
  loading,
  loaded,
  error,
  transactionCompleted
}

@immutable
class TransactionsState {
  final List<PendingTrasaction> pendingTransactions;
  final List<FinishedTransaction> finishedTransactions;
  final FetchTransactionStatus pendingTransactionFetchStatus;
  final FetchTransactionStatus finishedTransactionsFetchStatus;
  final PaymentWithChapaStatus paymentWithChapaStatus;

  const TransactionsState({
    required this.pendingTransactions,
    required this.finishedTransactions,
    required this.pendingTransactionFetchStatus,
    required this.finishedTransactionsFetchStatus,
    required this.paymentWithChapaStatus,
  });

  factory TransactionsState.initial() {
    return const TransactionsState(
      pendingTransactions: [],
      finishedTransactions: [],
      pendingTransactionFetchStatus: FetchTransactionStatus.loading,
      finishedTransactionsFetchStatus: FetchTransactionStatus.loading,
      paymentWithChapaStatus: PaymentWithChapaStatus.intial,
    );
  }

  TransactionsState copyWith({
    List<PendingTrasaction>? pendingTransactions,
    List<FinishedTransaction>? finishedTransactions,
    FetchTransactionStatus? pendingTransactionFetchStatus,
    FetchTransactionStatus? finishedTransactionsFetchStatus,
    PaymentWithChapaStatus? paymentWithChapaStatus,
  }) {
    return TransactionsState(
      pendingTransactions: pendingTransactions ?? this.pendingTransactions,
      finishedTransactions: finishedTransactions ?? this.finishedTransactions,
      pendingTransactionFetchStatus:
          pendingTransactionFetchStatus ?? this.pendingTransactionFetchStatus,
      finishedTransactionsFetchStatus: finishedTransactionsFetchStatus ??
          this.finishedTransactionsFetchStatus,
      paymentWithChapaStatus:
          paymentWithChapaStatus ?? this.paymentWithChapaStatus,
    );
  }
}
