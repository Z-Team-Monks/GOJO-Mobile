import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/features/profile/data_layer/repository/profile_repository.dart';
import 'package:gojo_landlord/features/profile/presentation/screens/widgets/end_contract_dialogue.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';
import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../data_layer/model/property_item.dart';
import '../../bloc/end_contract/end_contract_bloc.dart';

class RentedMediaItem extends StatelessWidget {
  final int propertyId;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String category;
  final Widget? trailingButtons;
  final String contractUrl;
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
      description: item.description,
      contractUrl: item.contractUrl ?? _templateContract,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PropertyMediaItem(
      title: title,
      thumbnailUrl: thumbnailUrl,
      trailingButtons: trailingButtons ??
          _TrailingButtons(
            onEndContractPressed: () => _showContract(context),
            onShowContractPressed: () => _showEndRentalDialog(context),
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

  Future<void> _showEndRentalDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => EndContractBloc(GetIt.I<ProfileRepositoryAPI>()),
          child: EndContractDialogue(
            propertyTitle: title,
            propertyId: propertyId,
          ),
        );
      },
    );
  }
}

class _TrailingButtons extends StatelessWidget {
  final void Function() onEndContractPressed;
  final void Function() onShowContractPressed;

  const _TrailingButtons({
    required this.onEndContractPressed,
    required this.onShowContractPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PropertyMediaItemButton(
          title: AppLocalizations.of(context)!.showContract,
          onClick: onEndContractPressed,
        ),
        const SizedBox(width: 10),
        PropertyMediaItemButton(
          title: AppLocalizations.of(context)!.endContract,
          onClick: onShowContractPressed,
        ),
      ],
    );
  }
}
