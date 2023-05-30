import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/bloc/create_property/create_property_bloc.dart';

import '../../../../data_layer/model/visiting_hour.dart';
import 'time_picker.dart';

class VisitingHoursPerDay extends StatefulWidget {
  final String day;

  const VisitingHoursPerDay({super.key, required this.day});

  @override
  State<VisitingHoursPerDay> createState() => _VisitingHoursPerDayState();
}

class _VisitingHoursPerDayState extends State<VisitingHoursPerDay> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.day),
          trailing: Switch(
            value: isExpanded,
            onChanged: (value) {
              setState(() {
                if (value) {
                  context.read<CreatePropertyBloc>().add(VisitingHourAdded(
                        VisitingHour(day: widget.day, from: 9, to: 11),
                      ));
                } else {
                  context
                      .read<CreatePropertyBloc>()
                      .add(VisitingHourRemoved(widget.day));
                }
                isExpanded = value;
              });
            },
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TimePicker(
                  day: widget.day,
                )),
              ],
            ),
          ),
      ],
    );
  }
}
