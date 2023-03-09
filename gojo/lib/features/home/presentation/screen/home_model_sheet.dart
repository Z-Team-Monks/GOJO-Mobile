import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/UI/design_tokens/padding.dart';
import 'package:gojo/UI/input_fields/text_field.dart';
import 'package:gojo/UI/input_fields/text_radio_button.dart';

class GojoHomeModalSheet extends StatelessWidget {
  GojoHomeModalSheet({super.key});

  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GojoPadding.large),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          GojoTextRadioButton(
            label: "Category",
            items: [
              "All",
              "Villa",
              "Condominium",
              "Apartment",
            ],
            onItemSelected: (String, int, bool) {},
          ),
          GojoTextRadioButton(
            label: "Facilities",
            items: [
              "All",
              "Swimming pool",
              "Gym",
              "Parking",
            ],
            onItemSelected: (String, int, bool) {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Location",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GojoTextField(labelText: ""),
          const SizedBox(height: 10),
          GojoTextRadioButton(
            label: "Rating",
            items: [
              "All",
              "1",
              "2",
              "3",
              "4",
              "5",
            ],
            onItemSelected: (String, int, bool) {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Price range",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return RangeSlider(
                values: _currentRangeValues,
                max: 100,
                divisions: 5,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
