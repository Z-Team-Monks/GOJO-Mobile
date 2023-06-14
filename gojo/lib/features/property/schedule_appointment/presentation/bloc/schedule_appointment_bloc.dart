import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../detail/data/model/appointment.dart';
import '../../../detail/data/repository/detail_repository.dart';

part 'schedule_appointment_event.dart';
part 'schedule_appointment_state.dart';

class ScheduleAppointmentBloc
    extends Bloc<ScheduleAppointmentEvent, ScheduleAppointmentState> {
  final PropertyDetailRepository propertyDetailRepository;
  final int propertyId;

  ScheduleAppointmentBloc({
    required this.propertyDetailRepository,
    required this.propertyId,
  }) : super(const ScheduleAppointmentState(timeSlots: [])) {
    on<TimeSlotSelectedChanged>((event, emit) {
      emit(
        state.copywith(
          timeSlot: event.timeSlot,
        ),
      );
    });

    on<DateChanged>((event, emit) {
      emit(
        state.copywith(
          date: event.date,
        ),
      );
    });

    on<ScheduleAppointmentSubmitted>((event, emit) async {
      emit(
        state.copywith(
          status: ScheduleAppointmentStatus.inprogress,
        ),
      );

      try {
        final appointment = AppointmentModel(
          propertyId: propertyId,
          date: DateFormat("yyyy-MM-dd").format(state.date!),
          timeSlot: state.timeSlot,
        );

        await propertyDetailRepository.scheduleAppointment(
          appointment,
        );

        emit(
          state.copywith(
            status: ScheduleAppointmentStatus.success,
          ),
        );
      } catch (e) {
        if (e is DioError) {
          debugPrint(e.response.toString());
        }
        emit(
          state.copywith(
            status: ScheduleAppointmentStatus.error,
          ),
        );
      } finally {
        emit(
          state.copywith(
            status: ScheduleAppointmentStatus.finished,
          ),
        );
      }
    });
  }
}
