import 'package:flutter/material.dart';
import 'package:gojo_landlord/features/profile/data_layer/model/property_item.dart';
import 'package:gojo_landlord/navigation/args/edit_property_args.dart';
import '../../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';
import '../../../../../constants/strings/app_routes.dart';

class InReviewMediaItem extends StatelessWidget {
  final PropertyItem propertyItem;
  final int propertyId;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String category;
  final Widget? trailingButtons;

  const InReviewMediaItem({
    Key? key,
    required this.propertyItem,
    required this.title,
    required this.thumbnailUrl,
    required this.propertyId,
    required this.description,
    required this.category,
    this.trailingButtons,
  }) : super(key: key);

  factory InReviewMediaItem.fromPropertyItem(PropertyItem item) {
    return InReviewMediaItem(
      propertyItem: item,
      title: item.title,
      thumbnailUrl: item.thumbnailUrl,
      propertyId: item.id,
      category: item.category,
      description: item.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PropertyMediaItem(
      showImage: false,
      title: title,
      thumbnailUrl: thumbnailUrl,
      subtitle: category,
      content: description,
      trailingButtons: _TrailingButton(propertyItem),
    );
  }
}

class _TrailingButton extends StatelessWidget {
  final PropertyItem propertyItem;
  const _TrailingButton(this.propertyItem);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.83,
          child: PropertyMediaItemButton(
            title: "Edit",
            onClick: () {
              Navigator.pushNamed(
                context,
                GojoRoutes.editProperty,
                arguments: EditPropertyArgs(propertyItem: propertyItem),
              );
            },
          ),
        ),
      ],
    );
  }
}
