import 'package:flutter/material.dart';

import '../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../Gojo-Mobile-Shared/UI/list_items/content_item.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import 'widgets/pending_payment_item.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  _buildLabel({required BuildContext context, required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GojoPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const Divider(thickness: 4, height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: ListView(
        children: [
          _buildLabel(context: context, label: "Pending"),
          GojoPendingPaymentItem(
            contentItem: GojoContentItem(
              image: AssetImage(Resources.gojoImages.sofa),
              title: "Mansion",
              content: "Rent for july",
              rightAlignedContent: "18,0000",
            ),
          ),
          GojoPendingPaymentItem(
            contentItem: GojoContentItem(
              image: AssetImage(Resources.gojoImages.sofa),
              title: "4 kilo Apartama",
              content: "Rent for july",
              rightAlignedContent: "18,0000",
            ),
          ),
          const SizedBox(height: 20),
          _buildLabel(context: context, label: "History"),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: GojoPadding.small,
                ),
                child: GojoContentItem(
                  image: AssetImage(Resources.gojoImages.sofa),
                  title: "Mansion",
                  content: "Rent for july",
                  rightAlignedTitle: "Mar 1,2023",
                  rightAlignedContent: "18,0000",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
