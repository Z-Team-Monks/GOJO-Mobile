import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';

import 'form_input_label.dart';

class TimePickerRow extends StatefulWidget {
  const TimePickerRow({super.key});

  @override
  State<TimePickerRow> createState() => _TimePickerRowState();
}

class _TimePickerRowState extends State<TimePickerRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormInputLabel(
          label: "Visiting hours",
          isRequired: true,
        ),
        Padding(
          padding: const EdgeInsets.all(GojoPadding.small),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: const HourDropdown(label: "Starts from"),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: const HourDropdown(label: "Ends at"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HourDropdown extends StatefulWidget {
  final String label;

  const HourDropdown({super.key, required this.label});
  @override
  State<HourDropdown> createState() => _HourDropdownState();
}

class _HourDropdownState extends State<HourDropdown> {
  int? _selectedHour;
  final _hours =
      List<int>.generate(24, (index) => index); // Generate a list of 0-23 hours

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<int>(
          underline: Container(),
          isExpanded: true,
          hint: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black.withOpacity(0.7),
                ),
          ),
          value: _selectedHour,
          items: _hours.map((int hour) {
            return DropdownMenuItem<int>(
              value: hour,
              child: Text('$hour:00'),
            );
          }).toList(),
          onChanged: (int? hour) {
            setState(() {
              _selectedHour = hour!;
            });
          },
        ),
      ),
    );
  }
}
