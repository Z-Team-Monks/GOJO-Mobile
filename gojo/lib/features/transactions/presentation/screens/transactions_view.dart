import 'package:flutter/material.dart';
import 'package:gojo/features/transactions/presentation/screens/widgets/pending_payment_item.dart';
import 'package:gojo/features/transactions/presentation/screens/widgets/tranaction_item.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Transactions",
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: "Pending"),
                Tab(text: "Completed"),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: List.filled(
                        3,
                        const PendingPaymentItem(
                          imageUrl: "",
                          title: "Nabek's mansion",
                          dueDate: "Oct 3,2023",
                          dueAmount: "18,000",
                        )),
                  ),
                  ListView(
                    children: List.filled(
                      3,
                      const TransactionItem(
                        imageUrl: "",
                        title: "Nabek's mansion",
                        paymentDate: "Mar 1,2023",
                        paidAmount: "18,0000",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
