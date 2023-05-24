import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo/features/property/schedule_appointment/presentation/bloc/schedule_appointment_bloc.dart';

class TimeSlotDropDown extends StatefulWidget {
  final List<String> freeTimeSlots;

  const TimeSlotDropDown({super.key, required this.freeTimeSlots});

  @override
  State<TimeSlotDropDown> createState() => _TimeSlotDropDownState();
}

class _TimeSlotDropDownState extends State<TimeSlotDropDown> {
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
      onChanged: (String? newSlot) {
        BlocProvider.of<ScheduleAppointmentBloc>(context).add(
          TimeSlotSelectedChanged(timeSlot: newSlot!),
        );
      },
      items: widget.freeTimeSlots.map<DropdownMenuItem<String>>((String value) {
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
