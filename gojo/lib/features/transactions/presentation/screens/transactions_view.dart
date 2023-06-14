import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../data_layer/repository/transactions_repository.dart';
import '../bloc/transactions_bloc.dart';
import 'widgets/finished_tranaction_item.dart';
import 'widgets/pending_transactoin_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: AppLocalizations.of(context)!.transactions,
      child: BlocProvider(
        create: (context) => TransactionsBloc(
          GetIt.I<TransactionsRepositoryAPI>(),
        )..add(LoadTransactions()),
        child: const TransactionsTabView(),
      ),
    );
  }
}

class TransactionsTabView extends StatefulWidget {
  const TransactionsTabView({
    super.key,
  });

  @override
  State<TransactionsTabView> createState() => _TransactionsTabViewState();
}

class _TransactionsTabViewState extends State<TransactionsTabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.pending),
              Tab(text: AppLocalizations.of(context)!.completed),
            ],
          ),
          const SizedBox(height: 8),
          const Expanded(
            child: TabBarView(
              children: [
                PendingPaymentsTab(),
                FinishedTransactionTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PendingPaymentsTab extends StatelessWidget {
  const PendingPaymentsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionsBloc, TransactionsState>(
      listener: (context, state) async {
        switch (state.paymentWithChapaStatus) {
          case PaymentWithChapaStatus.loading:
            GojoSnackBars.showLoading(context, "Getting chapa url...");
            break;
          case PaymentWithChapaStatus.error:
            GojoSnackBars.showError(context, "Can't get chapa url! Try again.");
            break;
          case PaymentWithChapaStatus.transactionCompleted:
            GojoSnackBars.showSuccess(context, "Transaction completed!");
            context.read<TransactionsBloc>().add(
                  ResetTransactionsBloc(),
                );
            context.read<TransactionsBloc>().add(
                  LoadTransactions(),
                );
            break;
          default:
        }
      },
      builder: (context, state) {
        switch (state.pendingTransactionFetchStatus) {
          case FetchTransactionStatus.loaded:
            if (state.pendingTransactions.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const Center(child: Text("No pending transactions!")),
              );
            }
            return ListView(children: [
              for (var transactionItem in state.pendingTransactions)
                PendingTransactionItem(
                  title: transactionItem.title,
                  imageUrl: transactionItem.thumbnailUrl,
                  dueAmount: transactionItem.amount.toString(),
                  dueDate: transactionItem.dueDate,
                  onPayNowPressed: () {
                    context.read<TransactionsBloc>().add(
                          PayNowClicked(transactionItem.id),
                        );
                  },
                ),
            ]);
          case FetchTransactionStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchTransactionStatus.error:
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Text(AppLocalizations.of(context)!.errorLoadingContent),
              ),
            );
        }
      },
    );
  }
}

class FinishedTransactionTab extends StatelessWidget {
  const FinishedTransactionTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        switch (state.finishedTransactionsFetchStatus) {
          case FetchTransactionStatus.loaded:
            if (state.finishedTransactions.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const Center(child: Text("No completed transactions!")),
              );
            }
            return ListView(children: [
              for (var transactionItem in state.finishedTransactions)
                FinishedTransactionItem(
                  title: transactionItem.title,
                  imageUrl: transactionItem.thumbnailUrl,
                  paidAmount: transactionItem.payedAmount.toString(),
                  paymentDate: transactionItem.paymentDate,
                )
            ]);
          case FetchTransactionStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchTransactionStatus.error:
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Text(AppLocalizations.of(context)!.errorLoadingContent),
              ),
            );
        }
      },
    );
  }
}
