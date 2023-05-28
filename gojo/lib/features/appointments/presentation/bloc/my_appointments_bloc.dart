import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gojo/features/appointments/data_layer/model/appointment.dart';
import 'package:gojo/features/appointments/data_layer/repository/my_appointments_repository.dart';

part 'my_appointments_event.dart';
part 'my_appointments_state.dart';

class MyAppointmentsBloc
    extends Bloc<MyAppointmentsEvent, MyAppointmentsState> {
  MyAppointmentsRepositoryAPI myAppointmentsRepositoryAPI;

  MyAppointmentsBloc(this.myAppointmentsRepositoryAPI)
      : super(MyAppointmentsState.initial()) {
    on<LoadMyAppointments>((event, emit) async {
      emit(state.copyWith(
        fetchAppointmentstatus: FetchAppointmentStatus.loading,
      ));

      try {
        final myAppointments =
            await myAppointmentsRepositoryAPI.getMyAppointments();

        emit(state.copyWith(
          appointments: myAppointments,
          fetchAppointmentstatus: FetchAppointmentStatus.success,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          fetchAppointmentstatus: FetchAppointmentStatus.error,
        ));
      }
    });

    on<CancelAppointment>((event, emit) async {
      try {
        emit(
          state.copyWith(
            cancelAppointmentStatus: CancelAppointmentStatus.loading,
          ),
        );

        await myAppointmentsRepositoryAPI
            .cancelAppointment(event.appointmentId);
        final updatedAppointments = state.appointments
            .where((element) => element.id != event.appointmentId)
            .toList();

        emit(state.copyWith(
          appointments: updatedAppointments,
          cancelAppointmentStatus: CancelAppointmentStatus.success,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          cancelAppointmentStatus: CancelAppointmentStatus.error,
        ));
      }
    });
  }
}
