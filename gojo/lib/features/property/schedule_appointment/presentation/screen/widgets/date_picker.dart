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
      onPressed: () async {
        await _selectDate(context);
        if (mounted) {
          BlocProvider.of<ScheduleAppointmentBloc>(context).add(
            DateChanged(date: selectedDate),
          );
        }
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      selectableDayPredicate: (day) {
        return widget.visitingHours?.contains(day) ?? false;
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

    while (!widget.visitingHours!.contains(firstAvailableDate)) {
      firstAvailableDate = firstAvailableDate.add(
        const Duration(days: 1),
      );
    }

    return firstAvailableDate;
  }

  DateTime _getLastAvailableDate(BuildContext context) {
    DateTime lastAvailableDate = _getFirstAvailableDate(context).add(
      const Duration(days: 30),
    );

    while (!widget.visitingHours!.contains(lastAvailableDate)) {
      lastAvailableDate = lastAvailableDate.subtract(
        const Duration(days: 1),
      );
    }

    return lastAvailableDate;
  }
}
