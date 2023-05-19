import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../bloc/schedule_appointment_bloc.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final List<int>? availableDays;
  const DatePicker({
    super.key,
    required this.label,
    this.availableDays,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate = DateTime.now();
  final dateFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GojoTextField(
          labelText: widget.label,
          controlller: dateFieldController,
          suffixIcon: InkWell(
            onTap: () {
              _selectDate(context);
              BlocProvider.of<ScheduleAppointmentBloc>(context).add(
                DateChanged(date: selectedDate!),
              );
            },
            child: const Icon(
              Icons.today,
              size: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 8.0),
          child: Text(
            "MM/DD/YYYY",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 11,
                ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      selectableDayPredicate: (day) {
        if (widget.availableDays != null) {
          return widget.availableDays?.contains(day.weekday) ?? true;
        }
        return true;
      },
      initialDate: _getFirstAvailableDate(context),
      firstDate: _getFirstAvailableDate(context),
      lastDate: _getLastAvailableDate(context),
    );
    if (picked != null && picked != selectedDate) {
      final formattedPickedDate = DateFormat("MM/d/yyyy").format(picked);
      dateFieldController.text = formattedPickedDate.toString();
      setState(() {
        selectedDate = picked;
      });
    }
  }

  DateTime _getFirstAvailableDate(BuildContext context) {
    final DateTime now = DateTime.now();
    if (widget.availableDays == null) {
      return now;
    }

    var offset = 0;
    for (int day = 0; day < 7; day++) {
      final currentWeekDay = (now.weekday - 1 + day) % 7 + 1;
      if (widget.availableDays?.contains(currentWeekDay) ?? false) {
        offset = day;
        break;
      }
    }

    final DateTime firstAvailableDate = DateTime(
      now.year,
      now.month,
      now.day + offset,
    );
    return firstAvailableDate;
  }

  DateTime _getLastAvailableDate(BuildContext context) {
    final DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month + 1,
      32,
    );
  }
}
