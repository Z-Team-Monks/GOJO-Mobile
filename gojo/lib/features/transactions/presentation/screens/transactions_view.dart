import 'package:flutter/material.dart';
import 'package:gojo/features/transactions/presentation/screens/widgets/pending_transactoin_item.dart';
import 'package:gojo/features/transactions/presentation/screens/widgets/finished_tranaction_item.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Transactions",
      child: DefaultTabController(
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
      ),
    );
  }
}

class FinishedTransactionTab extends StatelessWidget {
  const FinishedTransactionTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.filled(
        3,
        const FinishedTransactionItem(
          imageUrl: "",
          title: "Nabek's mansion",
          paymentDate: "Mar 1,2023",
          paidAmount: "18,0000",
        ),
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
    return ListView(
      children: List.filled(
          3,
          const PendingTransactionItem(
            imageUrl: "",
            title: "Sura's mansion",
            dueDate: "Oct 3,2023",
            dueAmount: "18,000",
          )),
    );
  }
}
