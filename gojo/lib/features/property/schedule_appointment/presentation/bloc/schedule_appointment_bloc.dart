import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../detail/data/model/appointment.dart';
import '../../../detail/data/repository/detail_repository.dart';

part 'schedule_appointment_event.dart';
part 'schedule_appointment_state.dart';

class ScheduleAppointmentBloc
    extends Bloc<ScheduleAppointmentEvent, ScheduleAppointmentState> {
  final PropertyDetailRepository propertyDetailRepository;

  ScheduleAppointmentBloc({
    required this.propertyDetailRepository,
  }) : super(const ScheduleAppointmentState(timeSlots: [])) {
    on<TimeSlotSelectedChanged>((event, emit) {
      emit(state.copywith(
        timeSlot: event.timeSlot,
      ));
    });

    on<DateChanged>((event, emit) {
      emit(state.copywith(
        date: event.date,
      ));
    });

    on<ScheduleAppointmentSubmitted>((event, emit) {
      emit(state.copywith(
        status: ScheduleAppointmentStatus.inprogress,
      ));

      try {
        final appointment = AppointmentModel(
          propertyId: "1",
          date: state.date.toString(),
          timeSlot: state.timeSlot,
        );
        propertyDetailRepository.scheduleAppointment(
          appointment,
        );

        emit(
          state.copywith(
            status: ScheduleAppointmentStatus.success,
          ),
        );
      } catch (e) {
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
