import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/list_items/mini_media_item.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo_landlord/constants/strings/app_routes.dart';

class PostedMediaItem extends StatelessWidget {
  const PostedMediaItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          GojoMiniMediaItem(
            image: Image.asset(Resources.gojoImages.sofa),
            title: "Villa, The Arsana Estate",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GojoBarButton(
                  title: "Applications",
                  customHeight: 35,
                  onClick: () {
                    Navigator.pushNamed(context, GojoRoutes.requests);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GojoBarButton(
                  title: "Appointments",
                  onClick: () {
                    Navigator.pushNamed(context, GojoRoutes.appointments);
                  },
                  customHeight: 35,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
