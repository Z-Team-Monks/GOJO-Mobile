import 'package:flutter/material.dart';
import 'package:gojo/features/appointment/schedule_appointment/presentation/widgets/date_picker.dart';
import 'package:gojo/features/appointment/schedule_appointment/presentation/widgets/time_slot_drop_down.dart';

class ScheduleAppointmentView extends StatelessWidget {
  const ScheduleAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            const DatePicker(label: "Date"),
            const SizedBox(height: 10),
            const TimeSlotDropDown(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Request Appointment"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
