import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/features/profile/data_layer/repository/profile_repository.dart';
import 'package:gojo_landlord/features/profile/presentation/screens/widgets/end_contract_dialogue.dart';

import '../../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';
import '../../../data_layer/model/property_item.dart';
import '../../bloc/end_contract/end_contract_bloc.dart';

class RentedMediaItem extends StatelessWidget {
  final int propertyId;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String category;
  final Widget? trailingButtons;

  const RentedMediaItem({
    Key? key,
    required this.title,
    required this.thumbnailUrl,
    required this.propertyId,
    required this.description,
    required this.category,
    this.trailingButtons,
  }) : super(key: key);

  factory RentedMediaItem.fromPropertyItem(PropertyItem item) {
    return RentedMediaItem(
      title: item.title,
      thumbnailUrl: item.thumbnailUrl,
      propertyId: item.id,
      category: item.category,
      description: item.desciption,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PropertyMediaItem(
      title: title,
      thumbnailUrl: thumbnailUrl,
      trailingButtons: trailingButtons ??
          _TrailingButton(
            () => _showEndRentalDialog(context),
          ),
      subtitle: category,
      content: description,
    );
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

class _TrailingButton extends StatelessWidget {
  final void Function() onTrailingButtonPressed;
  const _TrailingButton(this.onTrailingButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PropertyMediaItemButton(
          title: "End Contract",
          onClick: onTrailingButtonPressed,
        ),
      ],
    );
  }
}
