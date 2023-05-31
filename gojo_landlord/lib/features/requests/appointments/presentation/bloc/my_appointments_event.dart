part of 'my_appointments_bloc.dart';

@immutable
abstract class MyAppointmentsEvent {}

class LoadMyAppointments extends MyAppointmentsEvent {}

class ApproveAppointment extends MyAppointmentsEvent {
  final int appointmentId;

  ApproveAppointment(this.appointmentId);
}
