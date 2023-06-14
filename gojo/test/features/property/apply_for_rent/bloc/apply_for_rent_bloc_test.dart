import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo/features/property/apply_for_rent/bloc/apply_for_rent_bloc.dart';
import 'package:gojo/features/property/detail/data/repository/detail_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([PropertyDetailRepository])
import 'apply_for_rent_bloc_test.mocks.dart';

void main() {
  late ApplyForRentBloc applyForRentBloc;
  late MockPropertyDetailRepository mockRepository;

  setUp(() {
    mockRepository = MockPropertyDetailRepository();
    applyForRentBloc = ApplyForRentBloc(
      propertyDetailRepository: mockRepository,
      propertyId: 1,
    );
  });

  group('ApplyForRentBloc', () {
    final now = DateTime.now();
    blocTest<ApplyForRentBloc, ApplyForRentState>(
      'emits StartDateChanged state',
      build: () => applyForRentBloc,
      act: (bloc) => bloc.add(StartDateChanged(startDate: now)),
      expect: () => [
        ApplyForRentState(
          startDate: now,
          months: null,
          message: null,
          status: ApplicationStatus.editing,
        )
      ],
    );

    blocTest<ApplyForRentBloc, ApplyForRentState>(
      'emits MonthsChanged state',
      build: () => applyForRentBloc,
      act: (bloc) => bloc.add(MonthsChanged(months: 6)),
      expect: () => [
        const ApplyForRentState(
          startDate: null,
          months: 6,
          message: null,
          status: ApplicationStatus.editing,
        )
      ],
    );

    blocTest<ApplyForRentBloc, ApplyForRentState>(
      'emits MessageChanged state',
      build: () => applyForRentBloc,
      act: (bloc) => bloc.add(MessageChanged(message: 'Hello')),
      expect: () => [
        const ApplyForRentState(
          startDate: null,
          months: null,
          message: 'Hello',
          status: ApplicationStatus.editing,
        )
      ],
    );

    blocTest<ApplyForRentBloc, ApplyForRentState>(
      'emits ApplicationSubmitted state and success status',
      build: () => applyForRentBloc,
      skip: 3,
      act: (bloc) {
        bloc.add(MessageChanged(message: 'Hello'));
        bloc.add(MonthsChanged(months: 6));
        bloc.add(StartDateChanged(startDate: now));
        when(
          mockRepository.applyForRent(any),
        ).thenAnswer((_) => Future.value());
        bloc.add(ApplicationSubmitted());
      },
      expect: () => [
        ApplyForRentState(
          status: ApplicationStatus.inprogress,
          message: 'Hello',
          months: 6,
          startDate: now,
        ),
        ApplyForRentState(
          status: ApplicationStatus.success,
          message: 'Hello',
          months: 6,
          startDate: now,
        ),
        ApplyForRentState(
          status: ApplicationStatus.done,
          message: 'Hello',
          months: 6,
          startDate: now,
        ),
      ],
    );

    blocTest<ApplyForRentBloc, ApplyForRentState>(
      'emits ApplicationSubmitted state and error status',
      build: () => applyForRentBloc,
      act: (bloc) {
        when(
          mockRepository.applyForRent(any),
        ).thenThrow(Exception('Error'));
        bloc.add(ApplicationSubmitted());
      },
      expect: () => const [
        ApplyForRentState(status: ApplicationStatus.inprogress),
        ApplyForRentState(status: ApplicationStatus.error),
        ApplyForRentState(status: ApplicationStatus.done),
      ],
    );
  });
}
