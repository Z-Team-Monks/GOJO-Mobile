import 'package:flutter/material.dart';
import 'package:gojo_landlord/constants/strings/app_routes.dart';
import 'package:gojo_landlord/features/profile/data_layer/model/property_item.dart';

import '../../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';

class PostedMediaItem extends StatelessWidget {
  final int propertyId;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String category;
  final Widget? trailingButtons;

  const PostedMediaItem({
    Key? key,
    required this.title,
    required this.thumbnailUrl,
    required this.propertyId,
    required this.description,
    required this.category,
    this.trailingButtons,
  }) : super(key: key);

  factory PostedMediaItem.fromPropertyItem(PropertyItem item) {
    return PostedMediaItem(
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
      trailingButtons: trailingButtons ?? const _TrailingButtons(),
      subtitle: category,
      content: description,
    );
  }
}

class _TrailingButtons extends StatelessWidget {
  const _TrailingButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PropertyMediaItemButton(
          title: "Applications",
          onClick: () {
            Navigator.pushNamed(context, GojoRoutes.requests);
          },
        ),
        const SizedBox(width: 10),
        PropertyMediaItemButton(
          title: "Appointments",
          onClick: () {
            Navigator.pushNamed(context, GojoRoutes.appointments);
          },
        ),
      ],
    );
  }
}
