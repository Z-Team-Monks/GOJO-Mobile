part of 'my_appointments_bloc.dart';

@immutable
abstract class MyAppointmentsEvent {}

class LoadMyAppointments extends MyAppointmentsEvent {}

class CancelAppointment extends MyAppointmentsEvent {
  final String appointmentId;

  CancelAppointment(this.appointmentId);
}
