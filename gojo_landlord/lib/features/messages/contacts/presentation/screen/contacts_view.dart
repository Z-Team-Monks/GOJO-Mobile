import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/input_fields/search_bar.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/list_items/content_item.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo_landlord/constants/strings/app_routes.dart';

/// Represents a screen with a list view of user's chat history.
///
/// TODO: This feature is duplicated in the tenant app. It should be moved
///  to the shared folder if its functionality is the same in both apps.
class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: Column(
        children: [
          const GojoSearchBar(label: "Search"),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (() {
                  Navigator.pushNamed(context, GojoRoutes.chat);
                }),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: GojoPadding.small),
                  child: GojoContentItem(
                    image: AssetImage(Resources.gojoImages.headShot),
                    title: "Connor Fraizer",
                    content:
                        "What are the facility conditions? specially the WIFI? How about the facility condition specially the WIFI?",
                    rightAlignedTitle: "7:11 pm",
                    rightAlignedContent: "5",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
