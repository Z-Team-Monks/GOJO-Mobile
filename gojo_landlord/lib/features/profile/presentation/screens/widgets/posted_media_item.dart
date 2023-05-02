import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/list_items/mini_media_item.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo_landlord/constants/strings/app_routes.dart';
import 'package:gojo_landlord/features/profile/data_layer/model/property_item.dart';

class PostedMediaItem extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String propertyId;

  const PostedMediaItem({
    Key? key,
    required this.title,
    required this.thumbnailUrl,
    required this.propertyId,
  }) : super(key: key);

  factory PostedMediaItem.fromPropertyItem(PropertyItem item) {
    return PostedMediaItem(
      title: item.title,
      thumbnailUrl: item.thumbnailUrl,
      propertyId: item.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          GojoMiniMediaItem(
            image: Image.network(thumbnailUrl),
            title: title,
            size: GojoMiniMediaItemSize.large,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProstedMediaItemButton(
                title: "Applications",
                onClick: () {
                  Navigator.pushNamed(context, GojoRoutes.requests);
                },
              ),
              ProstedMediaItemButton(
                title: "Appointments",
                onClick: () {
                  Navigator.pushNamed(context, GojoRoutes.appointments);
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class ProstedMediaItemButton extends StatelessWidget {
  final String title;
  final Function onClick;

  const ProstedMediaItemButton({
    Key? key,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GojoBarButton(
        title: title,
        customHeight: 45,
        onClick: () {
          Navigator.pushNamed(context, GojoRoutes.requests);
        },
      ),
    );
  }
}
