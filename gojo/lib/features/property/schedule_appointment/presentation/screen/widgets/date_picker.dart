import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../Gojo-Mobile-Shared/UI/input_fields/date_field.dart';
import '../../../../detail/data/model/visiting_hours.dart';
import '../../bloc/schedule_appointment_bloc.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final VisitingHours? visitingHours;

  const DatePicker({
    super.key,
    required this.label,
    this.visitingHours,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  final dateFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GojoDateField(
      labelText: widget.label,
      controller: dateFieldController,
      onPressed: () {
        _selectDate(context);
        BlocProvider.of<ScheduleAppointmentBloc>(context).add(
          DateChanged(date: selectedDate),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      selectableDayPredicate: (day) {
        if (widget.visitingHours != null) {
          return widget.visitingHours?.contains(day) ?? true;
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
    DateTime firstAvailableDate = DateTime.now();

    for (var visitingHour in widget.visitingHours!.visitingHours) {
      DateTime dateTime = DateFormat('EEE').parse(visitingHour.day);

      if (dateTime.isAfter(firstAvailableDate)) {
        firstAvailableDate = dateTime;
      }
    }

    return firstAvailableDate;
  }

  DateTime _getLastAvailableDate(BuildContext context) {
    DateTime lastAvailableDate = _getFirstAvailableDate(context);

    for (var visitingHour in widget.visitingHours!.visitingHours) {
      DateTime dateTime = DateFormat('EEE').parse(visitingHour.day);
      if (dateTime.isAfter(lastAvailableDate)) {
        lastAvailableDate = dateTime;
      }
    }

    return lastAvailableDate.add(const Duration(days: 30));
  }
}
