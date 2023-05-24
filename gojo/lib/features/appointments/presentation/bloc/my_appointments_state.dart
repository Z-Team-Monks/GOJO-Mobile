part of 'my_appointments_bloc.dart';

enum FetchAppointmentStatus { loading, success, error }

enum CancelAppointmentStatus { initial, loading, success, error }

@immutable
class MyAppointmentsState {
  final List<Appointment> appointments;
  final FetchAppointmentStatus fetchAppointmentstatus;
  final CancelAppointmentStatus cancelAppointmentStatus;

  const MyAppointmentsState({
    required this.appointments,
    required this.fetchAppointmentstatus,
    required this.cancelAppointmentStatus,
  });

  factory MyAppointmentsState.initial() {
    return const MyAppointmentsState(
        appointments: [],
        fetchAppointmentstatus: FetchAppointmentStatus.loading,
        cancelAppointmentStatus: CancelAppointmentStatus.initial);
  }

  MyAppointmentsState copyWith({
    List<Appointment>? appointments,
    FetchAppointmentStatus? fetchAppointmentstatus,
    CancelAppointmentStatus? cancelAppointmentStatus,
  }) {
    return MyAppointmentsState(
      appointments: appointments ?? this.appointments,
      fetchAppointmentstatus:
          fetchAppointmentstatus ?? this.fetchAppointmentstatus,
      cancelAppointmentStatus:
          cancelAppointmentStatus ?? this.cancelAppointmentStatus,
    );
  }
}
