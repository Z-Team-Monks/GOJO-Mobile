import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../detail/data/model/availablity.dart';
import '../../../detail/data/repository/detail_repository.dart';
import '../bloc/schedule_appointment_bloc.dart';
import 'widgets/date_picker.dart';
import 'widgets/time_slot_drop_down.dart';

class ScheduleAppointmentView extends StatelessWidget {
  final AvailabilityModel availablity;

  const ScheduleAppointmentView({super.key, required this.availablity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleAppointmentBloc(
        propertyDetailRepository: GetIt.I<PropertyDetailRepository>(),
      ),
      child: _ScheduleAppointmentView(availablity: availablity),
    );
  }
}

class _ScheduleAppointmentView extends StatelessWidget {
  final AvailabilityModel availablity;

  const _ScheduleAppointmentView({
    required this.availablity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScheduleAppointmentBloc, ScheduleAppointmentState>(
      listener: (context, state) {
        switch (state.status) {
          case ScheduleAppointmentStatus.success:
            GojoSnackBars.showSuccess(
              context,
              "Successfully Scheduled an appointment",
            );
            break;
          case ScheduleAppointmentStatus.error:
            GojoSnackBars.showSuccess(
              context,
              "Can't Schedule an appointment",
            );
            break;
          case ScheduleAppointmentStatus.inprogress:
            break;
          case ScheduleAppointmentStatus.finished:
            Navigator.pop(context);
            break;
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              DatePicker(
                label: "Date",
                availableDays: availablity.days,
              ),
              const SizedBox(height: 10),
              BlocBuilder<ScheduleAppointmentBloc, ScheduleAppointmentState>(
                builder: (context, state) {
                  return TimeSlotDropDown(
                    //TODO: replace date with bloc state
                    freeTimeSlots: availablity.timeSlots["1"] ?? [],
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<ScheduleAppointmentBloc>(context).add(
                        ScheduleAppointmentSubmitted(),
                      );
                    },
                    child: const Text("Request Appointment"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
