import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';
import '../../../home/data_layer/model/property_item.dart';

class RentedMediaItem extends StatelessWidget {
  final int propertyId;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String category;
  final String contractUrl;
  final Widget? trailingButtons;

  static const _templateContract =
      "https://signaturely.com/wp-content/uploads/2020/06/rental-_agreement_template1.jpg";

  const RentedMediaItem({
    Key? key,
    required this.title,
    required this.thumbnailUrl,
    required this.propertyId,
    required this.description,
    required this.category,
    this.trailingButtons,
    this.contractUrl = _templateContract,
  }) : super(key: key);

  factory RentedMediaItem.fromPropertyItem(PropertyItem item) {
    return RentedMediaItem(
      title: item.title,
      thumbnailUrl: item.thumbnailUrl,
      propertyId: item.id,
      category: item.category,
      description: item.description ?? "",
      contractUrl: item.contractUrl ?? _templateContract,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PropertyMediaItem(
      title: title,
      thumbnailUrl: thumbnailUrl,
      trailingButtons: trailingButtons ??
          _TrailingButton(
            () => _showContract(context),
          ),
      subtitle: category,
      content: description,
    );
  }

  Future<void> _showContract(BuildContext context) async {
    final url = Uri.parse(contractUrl);
    if (!await launchUrl(url)) {
      GojoSnackBars.showError(
        context,
        AppLocalizations.of(context)!.errorLoadingContent,
      );
    }
  }
}

class _TrailingButton extends StatelessWidget {
  final void Function() onTrailingButtonPressed;
  const _TrailingButton(this.onTrailingButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PropertyMediaItemButton(
          title: AppLocalizations.of(context)!.showContract,
          onClick: onTrailingButtonPressed,
        ),
      ],
    );
  }
}
