import 'package:flutter/material.dart';

import '../form_input_label.dart';
import './visiting_hour_per_day.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VisitingHourSelector extends StatelessWidget {
  const VisitingHourSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final _daysOfWeek = [
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.thursday,
      AppLocalizations.of(context)!.friday,
      AppLocalizations.of(context)!.saturday,
      AppLocalizations.of(context)!.sunday,
    ];
    return Column(children: [
      FormInputLabel(
        label: AppLocalizations.of(context)!.visitingHours,
        isRequired: true,
      ),
      ..._daysOfWeek.map((day) => VisitingHoursPerDay(day: day)).toList(),
    ]);
  }
}
