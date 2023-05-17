part of 'transactions_bloc.dart';

enum FetchTransactionItemsStatus { loading, loaded, error }

@immutable
class TransactionsState {
  final List<PendingTransactionItem> pendingTransactionItems;
  final List<FinishedTransactionItem> finishedTransactionItems;
  final FetchTransactionItemsStatus pendingTransactionItemsFetchStatus;
  final FetchTransactionItemsStatus finishedTransactionItemsFetchStatus;

  const TransactionsState({
    required this.pendingTransactionItems,
    required this.finishedTransactionItems,
    required this.pendingTransactionItemsFetchStatus,
    required this.finishedTransactionItemsFetchStatus,
  });

  factory TransactionsState.initial() {
    return const TransactionsState(
      pendingTransactionItems: [],
      finishedTransactionItems: [],
      pendingTransactionItemsFetchStatus: FetchTransactionItemsStatus.loading,
      finishedTransactionItemsFetchStatus: FetchTransactionItemsStatus.loading,
    );
  }

  TransactionsState copyWith({
    List<PendingTransactionItem>? pendingTransactionItems,
    List<FinishedTransactionItem>? finishedTransactionItems,
    FetchTransactionItemsStatus? pendingTransactionItemsFetchStatus,
    FetchTransactionItemsStatus? finishedTransactionItemsFetchStatus,
  }) {
    return TransactionsState(
      pendingTransactionItems:
          pendingTransactionItems ?? this.pendingTransactionItems,
      finishedTransactionItems:
          finishedTransactionItems ?? this.finishedTransactionItems,
      pendingTransactionItemsFetchStatus: pendingTransactionItemsFetchStatus ??
          this.pendingTransactionItemsFetchStatus,
      finishedTransactionItemsFetchStatus:
          finishedTransactionItemsFetchStatus ??
              this.finishedTransactionItemsFetchStatus,
    );
  }
}
