import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/list_items/content_item.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';

class GojoPendingPaymentItem extends StatelessWidget {
  final GojoContentItem contentItem;
  const GojoPendingPaymentItem({super.key, required this.contentItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GojoPadding.small),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: GojoBorders.border(GojoBorderRadiusSize.small),
            color: Resources.gojoColors.limeGreen),
        padding: const EdgeInsets.all(GojoPadding.small),
        child: Column(
          children: [
            contentItem,
            const SizedBox(height: 10),
            GojoBarButton(
              title: "Pay now",
              onClick: () {},
              customHeight: 40,
            )
          ],
        ),
      ),
    );
  }
}
