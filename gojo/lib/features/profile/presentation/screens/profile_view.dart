import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/list_items/mini_media_item.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/constants/strings/app_routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(Resources.gojoImages.headShot),
                radius: 60,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: GojoPadding.large),
            child: Text(
              "Natnael Abay",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: "Rented"),
                      Tab(text: "Applied"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildProfileTab(
                            children: List.filled(
                          8,
                          _buildMiniMediaItem(
                            context,
                          ),
                        )),
                        _buildProfileTab(
                            children: List.filled(
                          8,
                          _buildMiniMediaItem(
                            context,
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab({required List<Widget> children}) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      children: children,
    );
  }

  Widget _buildMiniMediaItem(context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, GojoRoutes.propertyDetail);
      },
      child: GojoMiniMediaItem(
        image: Image.asset(Resources.gojoImages.sofa),
        title: "Villa, The Arsana Estate",
      ),
    );
  }
}