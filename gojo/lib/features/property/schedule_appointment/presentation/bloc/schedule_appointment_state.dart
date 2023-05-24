part of 'schedule_appointment_bloc.dart';

enum ScheduleAppointmentStatus { inprogress, success, error, finished }

class ScheduleAppointmentState extends Equatable {
  final ScheduleAppointmentStatus status;
  final DateTime date;
  final List<String> timeSlots;
  final String timeSlot;

  const ScheduleAppointmentState({
    this.status = ScheduleAppointmentStatus.inprogress,
    required this.date,
    required this.timeSlots,
    this.timeSlot = "",
  });

  ScheduleAppointmentState copywith({
    ScheduleAppointmentStatus? status,
    DateTime? date,
    List<String>? timeSlots,
    String? timeSlot,
  }) {
    return ScheduleAppointmentState(
      status: status ?? this.status,
      date: date ?? this.date,
      timeSlots: timeSlots ?? this.timeSlots,
      timeSlot: timeSlot ?? this.timeSlot,
    );
  }

  @override
  List<Object?> get props => [status, date, timeSlots, timeSlot];
}
