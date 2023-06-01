import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../detail/data/model/visiting_hours.dart';
import '../../../detail/data/repository/detail_repository.dart';
import '../bloc/schedule_appointment_bloc.dart';
import 'widgets/date_picker.dart';
import 'widgets/time_slot_drop_down.dart';

class ScheduleAppointmentView extends StatelessWidget {
  final VisitingHours visitingHours;

  const ScheduleAppointmentView({super.key, required this.visitingHours});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleAppointmentBloc(
        propertyDetailRepository: GetIt.I<PropertyDetailRepository>(),
      ),
      child: _ScheduleAppointmentView(visitingHours: visitingHours),
    );
  }
}

class _ScheduleAppointmentView extends StatelessWidget {
  final VisitingHours visitingHours;

  const _ScheduleAppointmentView({
    required this.visitingHours,
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
            GojoSnackBars.showLoading(
              context,
              "Scheduling an appointment...",
            );
            break;
          case ScheduleAppointmentStatus.finished:
            Navigator.pop(context);
            break;
          default:
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
                visitingHours: visitingHours,
              ),
              const SizedBox(height: 10),
              BlocBuilder<ScheduleAppointmentBloc, ScheduleAppointmentState>(
                builder: (context, state) {
                  debugPrint(state.date.toString());
                  return TimeSlotDropDown(
                    freeTimeSlots: visitingHours.getTimesByDay(state.date),
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
                  BlocBuilder<ScheduleAppointmentBloc,
                      ScheduleAppointmentState>(
                    builder: (context, state) {
                      return TextButton(
                        onPressed: state.isFormValid
                            ? () {
                                BlocProvider.of<ScheduleAppointmentBloc>(
                                        context)
                                    .add(ScheduleAppointmentSubmitted());
                              }
                            : null,
                        child: const Text("Request Appointment"),
                      );
                    },
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
