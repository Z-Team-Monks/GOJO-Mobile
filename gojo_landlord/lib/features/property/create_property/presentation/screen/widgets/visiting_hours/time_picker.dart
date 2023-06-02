import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/model/visiting_hour.dart';
import 'package:gojo_landlord/utils/date_time.dart';

import '../../../bloc/create_property/create_property_bloc.dart';
import '../../../../../../../utils/date_time.dart';

class TimePicker extends StatefulWidget {
  final String day;
  const TimePicker({super.key, required this.day});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  int? selectedStartHour = 9;
  int? selectedEndHour = 17;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePropertyBloc, CreatePropertyState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(GojoPadding.small),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: HourDropdown(
                  label: "Starts from",
                  selectedHour: selectedStartHour,
                  onChanged: (newHour) {
                    setState(() {
                      selectedStartHour = newHour;
                      if (!isStartEndHourValid()) {
                        selectedEndHour = selectedStartHour;
                      }
                      updateCurrentDayVisitingHour();
                    });
                  },
                ),
              ),
              Text(
                "-",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: HourDropdown(
                  label: "Ends at",
                  selectedHour: selectedEndHour,
                  onChanged: (newHour) {
                    setState(() {
                      selectedEndHour = newHour;
                      if (!isStartEndHourValid()) {
                        selectedStartHour = selectedEndHour;
                      }
                      updateCurrentDayVisitingHour();
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  updateCurrentDayVisitingHour() {
    final formattedStartHour = HourFormats.to12Hour(selectedStartHour!);
    final formattedEndHour = HourFormats.to12Hour(selectedEndHour!);
    context.read<CreatePropertyBloc>().add(
          VisitingHourAdded(VisitingHour(
            day: widget.day,
            from: formattedStartHour,
            to: formattedEndHour,
          )),
        );
  }

  bool isStartEndHourValid() {
    return selectedStartHour != null &&
        selectedEndHour != null &&
        selectedStartHour! <= selectedEndHour!;
  }
}

class HourDropdown extends StatefulWidget {
  final String label;
  final void Function(int?)? onChanged;
  final int? selectedHour;

  const HourDropdown(
      {super.key,
      required this.label,
      required this.onChanged,
      required this.selectedHour});
  @override
  State<HourDropdown> createState() => _HourDropdownState();
}

class _HourDropdownState extends State<HourDropdown> {
  // Generate a list of 0-23 hours.
  final _hours = List<int>.generate(24, (index) => index);

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
          value: widget.selectedHour,
          items: _hours.map((int hour) {
            return DropdownMenuItem<int>(
              value: hour,
              child: Text(HourFormats.to12Hour(hour)),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
