import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data_layer/model/finished_transaction.dart';
import '../../data_layer/model/pending_tranasction.dart';
import '../../data_layer/repository/transactions_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionsRepositoryAPI transactionRepository;
  TransactionsBloc(this.transactionRepository)
      : super(TransactionsState.initial()) {
    on<ResetTransactionsBloc>((event, emit) {
      emit(TransactionsState.initial());
    });
    on<LoadTransactions>((event, emit) async {
      emit(state.copyWith(
        finishedTransactionsFetchStatus: FetchTransactionStatus.loading,
        pendingTransactionFetchStatus: FetchTransactionStatus.loading,
        paymentWithChapaStatus: PaymentWithChapaStatus.intial,
      ));

      try {
        final pendingTransactions =
            await transactionRepository.getPendingTransactions();

        emit(state.copyWith(
          pendingTransactions: pendingTransactions,
          pendingTransactionFetchStatus: FetchTransactionStatus.loaded,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          pendingTransactionFetchStatus: FetchTransactionStatus.error,
        ));
      }

      try {
        final finishedTransactions =
            await transactionRepository.getFinishedTransactions();

        emit(state.copyWith(
          finishedTransactions: finishedTransactions,
          finishedTransactionsFetchStatus: FetchTransactionStatus.loaded,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          finishedTransactionsFetchStatus: FetchTransactionStatus.error,
        ));
      }
    });

    on<PayNowClicked>((event, emit) async {
      emit(state.copyWith(
        paymentWithChapaStatus: PaymentWithChapaStatus.loading,
      ));
      try {
        final url = await transactionRepository.getCheckOutUrl(
          event.transactionId,
        );
        emit(state.copyWith(
          paymentWithChapaStatus: PaymentWithChapaStatus.loaded,
        ));
        await launchUrl(
          Uri.parse(url),
          webOnlyWindowName: "Gojo: Chappa",
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
          ),
        );

        debugPrint("launced");
        emit(state.copyWith(
          paymentWithChapaStatus: PaymentWithChapaStatus.transactionCompleted,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          paymentWithChapaStatus: PaymentWithChapaStatus.error,
        ));
      }
    });
  }
}
