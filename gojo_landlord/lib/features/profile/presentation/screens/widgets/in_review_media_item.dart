import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/list_items/mini_media_item.dart';
import 'package:gojo_landlord/features/profile/data_layer/model/property_item.dart';

class InReviewMediaItem extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String propertyId;

  const InReviewMediaItem({
    Key? key,
    required this.title,
    required this.thumbnailUrl,
    required this.propertyId,
  }) : super(key: key);

  factory InReviewMediaItem.fromPropertyItem(PropertyItem item) {
    return InReviewMediaItem(
      title: item.title,
      thumbnailUrl: item.thumbnailUrl,
      propertyId: item.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GojoMiniMediaItem(
        image: Image.network(thumbnailUrl),
        title: title,
        size: GojoMiniMediaItemSize.large,
      ),
    );
  }
}
