import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/list_items/content_item.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';

class FinishedTransactionItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String paymentDate;
  final String paidAmount;

  const FinishedTransactionItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.paymentDate,
    required this.paidAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(GojoPadding.small),
      margin: const EdgeInsets.symmetric(vertical: GojoPadding.extraSmall),
      decoration: BoxDecoration(
        borderRadius: GojoBorders.border(GojoBorderRadiusSize.small),
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
      child: GojoContentItem(
        // TODO: Use network image.
        image: AssetImage(Resources.gojoImages.sofa),
        title: title,
        rightAlignedTitle: "Paid on $paymentDate",
        rightAlignedContent: paidAmount,
      ),
    );
  }
}
