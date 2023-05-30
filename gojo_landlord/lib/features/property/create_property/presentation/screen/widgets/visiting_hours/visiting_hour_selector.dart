import 'package:flutter/material.dart';

import '../form_input_label.dart';
import './visiting_hour_per_day.dart';

class VisitingHourSelector extends StatelessWidget {
  const VisitingHourSelector({super.key});

  static const _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const FormInputLabel(
        label: "Visiting hours",
        isRequired: true,
      ),
      ...VisitingHourSelector._daysOfWeek
          .map((day) => VisitingHoursPerDay(day: day))
          .toList(),
    ]);
  }
}
