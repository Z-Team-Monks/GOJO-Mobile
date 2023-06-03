import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/model/appointment.dart';
import '../../data_layer/repository/my_appointments_repository.dart';

part 'my_appointments_event.dart';
part 'my_appointments_state.dart';

class MyAppointmentsBloc
    extends Bloc<MyAppointmentsEvent, MyAppointmentsState> {
  MyAppointmentsRepositoryAPI myAppointmentsRepositoryAPI;
  int propertyId;

  MyAppointmentsBloc({
    required this.myAppointmentsRepositoryAPI,
    required this.propertyId,
  }) : super(MyAppointmentsState.initial()) {
    on<LoadMyAppointments>((event, emit) async {
      emit(state.copyWith(
        fetchAppointmentstatus: FetchAppointmentStatus.loading,
      ));

      try {
        final myAppointments =
            await myAppointmentsRepositoryAPI.getMyAppointments(propertyId);

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

    on<ApproveAppointment>((event, emit) async {
      try {
        emit(
          state.copyWith(
            approveAppointmentStatus: ApproveAppointmentStatus.loading,
          ),
        );

        await myAppointmentsRepositoryAPI.approveAppointment(
          event.appointmentId,
        );

        emit(state.copyWith(
          approveAppointmentStatus: ApproveAppointmentStatus.success,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          approveAppointmentStatus: ApproveAppointmentStatus.error,
        ));
      }
    });
  }
}
