import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo/features/appointments/data_layer/repository/my_appointments_repository.dart';
import 'package:gojo/features/appointments/presentation/bloc/my_appointments_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import the generated mocks file
import 'appointments_bloc_test.mocks.dart';

// Annotate the test file with @GenerateMocks
@GenerateMocks([MyAppointmentsRepositoryAPI])
void main() {
  late MyAppointmentsBloc myAppointmentsBloc;
  late MockMyAppointmentsRepositoryAPI mockRepository;

  setUp(() {
    mockRepository = MockMyAppointmentsRepositoryAPI();
    myAppointmentsBloc = MyAppointmentsBloc(mockRepository);
  });

  group('MyAppointmentsBloc', () {
    blocTest<MyAppointmentsBloc, MyAppointmentsState>(
      'emits correct states for LoadMyAppointments event',
      build: () => myAppointmentsBloc,
      act: (bloc) {
        when(mockRepository.getMyAppointments())
            .thenAnswer((_) => Future.value([]));
        bloc.add(LoadMyAppointments());
      },
      expect: () => const [
        MyAppointmentsState(
          appointments: [],
          fetchAppointmentstatus: FetchAppointmentStatus.loading,
          cancelAppointmentStatus: CancelAppointmentStatus.initial,
        ),
        MyAppointmentsState(
          appointments: [],
          fetchAppointmentstatus: FetchAppointmentStatus.success,
          cancelAppointmentStatus: CancelAppointmentStatus.initial,
        ),
      ],
    );

    blocTest<MyAppointmentsBloc, MyAppointmentsState>(
      'emits correct states for CancelAppointment event',
      build: () => myAppointmentsBloc,
      act: (bloc) {
        when(mockRepository.cancelAppointment(any))
            .thenAnswer((_) => Future.value());
        bloc.add(CancelAppointment(1));
      },
      expect: () => const [
        MyAppointmentsState(
          appointments: [],
          fetchAppointmentstatus: FetchAppointmentStatus.loading,
          cancelAppointmentStatus: CancelAppointmentStatus.loading,
        ),
        MyAppointmentsState(
          appointments: [],
          fetchAppointmentstatus: FetchAppointmentStatus.loading,
          cancelAppointmentStatus: CancelAppointmentStatus.success,
        ),
      ],
    );

    blocTest<MyAppointmentsBloc, MyAppointmentsState>(
      'handles error during CancelAppointment event',
      build: () => myAppointmentsBloc,
      act: (bloc) {
        when(mockRepository.cancelAppointment(any))
            .thenThrow(Exception('Error'));
        bloc.add(CancelAppointment(1));
      },
      expect: () => const [
        MyAppointmentsState(
          appointments: [],
          fetchAppointmentstatus: FetchAppointmentStatus.loading,
          cancelAppointmentStatus: CancelAppointmentStatus.loading,
        ),
        MyAppointmentsState(
          appointments: [],
          fetchAppointmentstatus: FetchAppointmentStatus.loading,
          cancelAppointmentStatus: CancelAppointmentStatus.error,
        ),
      ],
    );

    // Add more blocTest blocks for other events if necessary
  });
}
