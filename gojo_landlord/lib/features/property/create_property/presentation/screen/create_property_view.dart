import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/input_fields/text_radio_button.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/resources/resources.dart';

class CreatePropertyView extends StatelessWidget {
  const CreatePropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    const facilities = [
      "Parking",
      "Swimming",
      "Wifi",
      "Restaurant",
      "Cafe",
      "Parking",
      "Swimming",
      "Wifi",
      "Restaurant",
      "Cafe",
      "Parking",
      "Swimming",
      "Wifi",
      "Restaurant",
      "Cafe"
    ];
    return GojoParentView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GojoPadding.small),
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Create a post",
                  style: TextStyle(
                    color: Resources.gojoColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GojoTextField(labelText: "Title"),
            SizedBox(height: 10),
            GojoTextField(
              labelText: "Description",
              maxLines: 5,
            ),
            SizedBox(height: 10),
            GojoTextField(labelText: "Location"),
            SizedBox(height: 10),
            GojoTextField(labelText: "Number of bedrooms"),
            SizedBox(height: 10),
            GojoTextField(labelText: "Number of showers"),
            SizedBox(height: 10),
            GojoTextField(labelText: "Number of rooms"),
            SizedBox(height: 10),
            GojoTextField(labelText: "Floors"),
            SizedBox(height: 10),
            Container(
              height: 200,
              child: ListView(children: [
                GojoTextRadioButton(
                  label: "Facilities",
                  items: facilities,
                  isRadio: false,
                ),
              ]),
            ),
            SizedBox(height: 20),
            GojoBarButton(title: "Save", onClick: (() {})),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
