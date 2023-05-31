part of 'my_appointments_bloc.dart';

enum FetchAppointmentStatus { loading, success, error }

enum ApproveAppointmentStatus { initial, loading, success, error }

@immutable
class MyAppointmentsState {
  final List<Appointment> appointments;
  final FetchAppointmentStatus fetchAppointmentstatus;
  final ApproveAppointmentStatus approveAppointmentStatus;

  const MyAppointmentsState({
    required this.appointments,
    required this.fetchAppointmentstatus,
    required this.approveAppointmentStatus,
  });

  factory MyAppointmentsState.initial() {
    return const MyAppointmentsState(
        appointments: [],
        fetchAppointmentstatus: FetchAppointmentStatus.loading,
        approveAppointmentStatus: ApproveAppointmentStatus.initial);
  }

  MyAppointmentsState copyWith({
    List<Appointment>? appointments,
    FetchAppointmentStatus? fetchAppointmentstatus,
    ApproveAppointmentStatus? approveAppointmentStatus,
  }) {
    return MyAppointmentsState(
      appointments: appointments ?? this.appointments,
      fetchAppointmentstatus:
          fetchAppointmentstatus ?? this.fetchAppointmentstatus,
      approveAppointmentStatus:
          approveAppointmentStatus ?? this.approveAppointmentStatus,
    );
  }
}
