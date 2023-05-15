import 'package:flutter/material.dart';

class TimeSlotDropDown extends StatefulWidget {
  const TimeSlotDropDown({super.key});

  @override
  State<TimeSlotDropDown> createState() => _TimeSlotDropDownState();
}

class _TimeSlotDropDownState extends State<TimeSlotDropDown> {
  List<String> list = <String>['3:00 PM', '5:00 PM', '6:00 PM', '7:00 PM'];
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: dropdownValue,
      hint: Text(
        "Pick a Time Slot",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black.withOpacity(0.7),
            ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }).toList(),
    );
  }
}
