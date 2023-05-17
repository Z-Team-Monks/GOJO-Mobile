import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/list_items/content_item.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';

class PendingTransactionItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String dueDate;
  final String dueAmount;
  final void Function()? onPayNowPressed;
  const PendingTransactionItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.dueDate,
    required this.dueAmount,
    required this.onPayNowPressed,
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
        child: ExpandablePanel(
          header: _buildHeader(),
          collapsed: Container(),
          expanded: _buildPayButton(),
        ));
  }

  Widget _buildPayButton() {
    return InkWell(
      onTap: onPayNowPressed,
      child: Container(
        height: 35,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: GojoBarButton(title: "Pay now", onClick: () {}),
      ),
    );
  }

  GojoContentItem _buildHeader() {
    return GojoContentItem(
      image: NetworkImage(imageUrl),
      title: title,
      rightAlignedTitle: "Due $dueDate",
      rightAlignedContent: dueAmount,
    );
  }
}
