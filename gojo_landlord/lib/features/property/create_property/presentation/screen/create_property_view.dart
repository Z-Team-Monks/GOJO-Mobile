import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_radio_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

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
      label: "Add a new property",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GojoPadding.small),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            GojoTextField(labelText: "Title"),
            const SizedBox(height: 10),
            GojoTextField(
              labelText: "Description",
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            GojoTextField(labelText: "Number of bedrooms"),
            const SizedBox(height: 10),
            GojoTextField(labelText: "Number of bathrooms"),
            const SizedBox(height: 10),
            GojoTextField(labelText: "Square area"),
            const SizedBox(height: 10),
            CategoryDropdown(),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView(children: const [
                GojoTextRadioButton(
                  label: "Facilities",
                  items: facilities,
                  isRadio: false,
                ),
              ]),
            ),
            const SizedBox(height: 20),
            GojoBarButton(title: "Save", onClick: (() {})),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

final list = ["Apartment", "Condominium", "House", "Office", "Other"];

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Category",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              underline: Container(),
              isExpanded: true,
              hint: Text(
                "Pick a category",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
