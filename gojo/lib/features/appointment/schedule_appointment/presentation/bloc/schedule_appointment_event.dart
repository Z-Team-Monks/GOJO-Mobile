part of 'schedule_appointment_bloc.dart';

abstract class ScheduleAppointmentEvent extends Equatable {}

class DateChanged extends ScheduleAppointmentEvent {
  final DateTime date;

  DateChanged({required this.date});

  @override
  List<Object?> get props => [date];
}

class TimeSlotSelectedChanged extends ScheduleAppointmentEvent {
  final String timeSlot;

  TimeSlotSelectedChanged({required this.timeSlot});

  @override
  List<Object> get props => [timeSlot];
}

class TimeSlotChanged extends ScheduleAppointmentEvent {
  final List<String> timeSlots;

  TimeSlotChanged({required this.timeSlots});

  @override
  List<Object> get props => [timeSlots];
}

class ScheduleAppointmentInProgress extends ScheduleAppointmentEvent {
  @override
  List<Object> get props => [];
}

class ScheduleAppointmentSubmitted extends ScheduleAppointmentEvent {
  @override
  List<Object> get props => [];
}
