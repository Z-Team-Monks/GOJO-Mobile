import 'package:flutter/material.dart';
import 'package:gojo_landlord/features/profile/data_layer/model/property_item.dart';
import '../../../../../Gojo-Mobile-Shared/UI/list_items/property_media_item.dart';

class InReviewMediaItem extends StatelessWidget {
  final int propertyId;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String category;
  final Widget? trailingButtons;

  const InReviewMediaItem({
    Key? key,
    required this.title,
    required this.thumbnailUrl,
    required this.propertyId,
    required this.description,
    required this.category,
    this.trailingButtons,
  }) : super(key: key);

  factory InReviewMediaItem.fromPropertyItem(PropertyItem item) {
    return InReviewMediaItem(
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
      content: '',
      subtitle: '',
    );
  }
}
