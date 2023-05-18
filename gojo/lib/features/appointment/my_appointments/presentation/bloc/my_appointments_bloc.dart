import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gojo/features/appointment/my_appointments/data_layer/repository/my_appointments_repository.dart';
import 'package:gojo/features/appointment/my_appointments/presentation/screen/widgets/my_appointment_item.dart';
import 'package:meta/meta.dart';

part 'my_appointments_event.dart';
part 'my_appointments_state.dart';

class MyAppointmentsBloc
    extends Bloc<MyAppointmentsEvent, MyAppointmentsState> {
  MyAppointmentsRepositoryAPI myAppointmentsRepositoryAPI;

  MyAppointmentsBloc(this.myAppointmentsRepositoryAPI)
      : super(MyAppointmentsState.initial()) {
    on<LoadMyAppointments>((event, emit) async {
      emit(state.copyWith(
        status: FetchMyAppointmentsStatus.loading,
      ));

      try {
        debugPrint("Loading my appointments");
        final myAppointments =
            await myAppointmentsRepositoryAPI.getMyAppointments();
        final myAppointmentItems = myAppointments
            .map((appointment) => MyAppointementsItem(
                  fullName: appointment.fullName,
                  phoneNumber: appointment.phoneNumber,
                  date: appointment.date,
                ))
            .toList();
        emit(state.copyWith(
          appointments: myAppointmentItems,
          status: FetchMyAppointmentsStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: FetchMyAppointmentsStatus.error,
        ));
      }
    });
  }
}
