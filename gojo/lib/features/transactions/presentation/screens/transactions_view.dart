import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/features/transactions/data_layer/repository/transactions_repository.dart';
import 'package:gojo/features/transactions/presentation/bloc/transactions_bloc.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Transactions",
      child: BlocProvider(
        create: (context) =>
            TransactionsBloc(GetIt.I<TransactionsRepositoryAPI>())
              ..add(
                LoadTransactions(),
              ),
        child: const TransactionsTabView(),
      ),
    );
  }
}

class TransactionsTabView extends StatelessWidget {
  const TransactionsTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: const [
          TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Completed"),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
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
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        switch (state.pendingTransactionItemsFetchStatus) {
          case FetchTransactionItemsStatus.loaded:
            return ListView(
              children: state.pendingTransactionItems,
            );
          case FetchTransactionItemsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchTransactionItemsStatus.error:
            return const Center(child: Text("Error"));
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
        switch (state.finishedTransactionItemsFetchStatus) {
          case FetchTransactionItemsStatus.loaded:
            return ListView(
              children: state.finishedTransactionItems,
            );
          case FetchTransactionItemsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchTransactionItemsStatus.error:
            return const Center(child: Text("Error"));
        }
      },
    );
  }
}
