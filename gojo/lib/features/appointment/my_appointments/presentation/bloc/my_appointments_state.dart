part of 'my_appointments_bloc.dart';

enum FetchMyAppointmentsStatus { loading, loaded, error }

@immutable
class MyAppointmentsState {
  final List<MyAppointementsItem> appointments;
  final FetchMyAppointmentsStatus status;

  const MyAppointmentsState({
    required this.appointments,
    required this.status,
  });

  factory MyAppointmentsState.initial() {
    return const MyAppointmentsState(
      appointments: [],
      status: FetchMyAppointmentsStatus.loading,
    );
  }

  MyAppointmentsState copyWith({
    List<MyAppointementsItem>? appointments,
    FetchMyAppointmentsStatus? status,
  }) {
    return MyAppointmentsState(
      appointments: appointments ?? this.appointments,
      status: status ?? this.status,
    );
  }
}
