import 'package:bloc/bloc.dart';
import 'package:gojo/features/transactions/data_layer/repository/transactions_repository.dart';
import 'package:gojo/features/transactions/presentation/screens/widgets/finished_tranaction_item.dart';
import 'package:gojo/features/transactions/presentation/screens/widgets/pending_transactoin_item.dart';
import 'package:meta/meta.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepositoryAPI transactionRepository;
  TransactionsBloc(this.transactionRepository)
      : super(TransactionsState.initial()) {
    on<LoadTransactions>((event, emit) async {
      emit(state.copyWith(
        finishedTransactionItemsFetchStatus:
            FetchTransactionItemsStatus.loading,
        pendingTransactionItemsFetchStatus: FetchTransactionItemsStatus.loading,
      ));

      try {
        final finishedTransactions =
            await transactionRepository.getFinishedTransactions();
        final finishedTransactionItems = finishedTransactions
            .map((transactionItem) => FinishedTransactionItem(
                  title: transactionItem.title,
                  imageUrl: transactionItem.thumbnailUrl,
                  paidAmount: transactionItem.payedAmount.toString(),
                  paymentDate: transactionItem.paymentDate,
                ))
            .toList();

        emit(state.copyWith(
          finishedTransactionItems: finishedTransactionItems,
          finishedTransactionItemsFetchStatus:
              FetchTransactionItemsStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          finishedTransactionItemsFetchStatus:
              FetchTransactionItemsStatus.error,
        ));
      }

      try {
        final pendingTransactions =
            await transactionRepository.getPendingTransactions();
        final pendingTransactionItems = pendingTransactions
            .map((transactionItem) => PendingTransactionItem(
                  title: transactionItem.title,
                  imageUrl: transactionItem.thumbnailUrl,
                  dueAmount: transactionItem.amount.toString(),
                  dueDate: transactionItem.dueDate,
                ))
            .toList();

        emit(state.copyWith(
          pendingTransactionItems: pendingTransactionItems,
          pendingTransactionItemsFetchStatus:
              FetchTransactionItemsStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          pendingTransactionItemsFetchStatus: FetchTransactionItemsStatus.error,
        ));
      }
    });
  }
}
