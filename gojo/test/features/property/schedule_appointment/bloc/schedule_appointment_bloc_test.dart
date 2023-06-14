import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo/features/property/schedule_appointment/presentation/bloc/schedule_appointment_bloc.dart';

import 'package:mockito/mockito.dart';

import '../../apply_for_rent/bloc/apply_for_rent_bloc_test.mocks.dart';

void main() {
  late ScheduleAppointmentBloc scheduleAppointmentBloc;
  late MockPropertyDetailRepository mockRepository;

  setUp(() {
    mockRepository = MockPropertyDetailRepository();
    scheduleAppointmentBloc = ScheduleAppointmentBloc(
      propertyDetailRepository: mockRepository,
      propertyId: 1,
    );
  });

  group('ScheduleAppointmentBloc', () {
    final now = DateTime.now();
    blocTest<ScheduleAppointmentBloc, ScheduleAppointmentState>(
      'emits DateChanged state',
      build: () => scheduleAppointmentBloc,
      act: (bloc) => bloc.add(DateChanged(date: now)),
      expect: () => [
        ScheduleAppointmentState(
          status: ScheduleAppointmentStatus.init,
          date: now,
          timeSlots: const [],
        ),
      ],
    );

    blocTest<ScheduleAppointmentBloc, ScheduleAppointmentState>(
      'emits TimeSlotSelectedChanged state',
      build: () => scheduleAppointmentBloc,
      act: (bloc) => bloc.add(TimeSlotSelectedChanged(timeSlot: '10:00 AM')),
      expect: () => [
        const ScheduleAppointmentState(
          timeSlots: [],
          timeSlot: '10:00 AM',
        ),
      ],
    );

    blocTest<ScheduleAppointmentBloc, ScheduleAppointmentState>(
      'emits ScheduleAppointmentStatus.success state',
      build: () => scheduleAppointmentBloc,
      skip: 2,
      act: (bloc) {
        bloc.add(DateChanged(date: now));
        bloc.add(TimeSlotSelectedChanged(timeSlot: '10:00 AM'));
        when(mockRepository.scheduleAppointment(any))
            .thenAnswer((_) => Future.value());
        bloc.add(ScheduleAppointmentSubmitted());
      },
      expect: () => [
        ScheduleAppointmentState(
          status: ScheduleAppointmentStatus.inprogress,
          timeSlots: const [],
          timeSlot: '10:00 AM',
          date: now,
        ),
        ScheduleAppointmentState(
          status: ScheduleAppointmentStatus.success,
          timeSlots: const [],
          timeSlot: '10:00 AM',
          date: now,
        ),
        ScheduleAppointmentState(
          status: ScheduleAppointmentStatus.finished,
          timeSlots: const [],
          timeSlot: '10:00 AM',
          date: now,
        ),
      ],
    );

    blocTest<ScheduleAppointmentBloc, ScheduleAppointmentState>(
      'handles error',
      build: () => scheduleAppointmentBloc,
      act: (bloc) {
        when(mockRepository.scheduleAppointment(any))
            .thenThrow(Exception('Error'));
        bloc.add(ScheduleAppointmentSubmitted());
      },
      expect: () => const [
        ScheduleAppointmentState(
          status: ScheduleAppointmentStatus.inprogress,
          timeSlots: [],
        ),
        ScheduleAppointmentState(
          status: ScheduleAppointmentStatus.error,
          timeSlots: [],
        ),
        ScheduleAppointmentState(
          status: ScheduleAppointmentStatus.finished,
          timeSlots: [],
        ),
      ],
    );
  });
}
