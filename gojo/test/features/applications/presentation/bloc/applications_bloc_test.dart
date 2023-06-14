import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo/Gojo-Mobile-Shared/core/repository/application/application_repository.dart';
import 'package:gojo/features/applications/presentation/bloc/applications_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Import the generated mocks file
import 'applications_bloc_test.mocks.dart';

// Annotate the test file with @GenerateMocks
@GenerateMocks([ApplicationsRepositoryAPI])
void main() {
  late ApplicationsBloc applicationsBloc;
  late MockApplicationsRepositoryAPI mockRepository;

  setUp(() {
    mockRepository = MockApplicationsRepositoryAPI();
    applicationsBloc = ApplicationsBloc(mockRepository);
  });

  group('ApplicationsBloc', () {
    blocTest<ApplicationsBloc, ApplicationsState>(
      'emits correct states for LoadApplications event',
      build: () => applicationsBloc,
      act: (bloc) {
        when(mockRepository.getApprovedApplications())
            .thenAnswer((_) => Future.value([]));
        when(mockRepository.getPendingApplications())
            .thenAnswer((_) => Future.value([]));
        when(mockRepository.getRejectedApplications())
            .thenAnswer((_) => Future.value([]));
        bloc.add(LoadApplications());
      },
      expect: () => const [
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.init,
        ),
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loaded,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.init,
        ),
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loaded,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loaded,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.init,
        ),
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loaded,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loaded,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loaded,
          withdrawApplicationStatus: WithdrawApplicationStatus.init,
        ),
      ],
    );

    blocTest<ApplicationsBloc, ApplicationsState>(
      'emits correct states for WithdrawPendingApplication event',
      build: () => applicationsBloc,
      act: (bloc) {
        when(mockRepository.withdrawPendingApplication(any))
            .thenAnswer((_) => Future.value());
        bloc.add(WithdrawPendingApplication(1));
      },
      expect: () => const [
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.loading,
        ),
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.success,
        ),
      ],
    );

    blocTest<ApplicationsBloc, ApplicationsState>(
      'handles error during WithdrawPendingApplication event',
      build: () => applicationsBloc,
      act: (bloc) {
        when(mockRepository.withdrawPendingApplication(any))
            .thenThrow(Exception('Error'));
        bloc.add(WithdrawPendingApplication(1));
      },
      expect: () => const [
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.loading,
        ),
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.error,
        ),
      ],
    );

    blocTest<ApplicationsBloc, ApplicationsState>(
      'emits correct states for LoadPendingApplications event',
      build: () => applicationsBloc,
      act: (bloc) {
        when(mockRepository.getPendingApplications())
            .thenAnswer((_) => Future.value([]));
        bloc.add(LoadPendingApplications());
      },
      expect: () => const [
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.init,
        ),
        ApplicationsState(
          pendingApplications: [],
          approvedApplications: [],
          rejectedApplications: [],
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loaded,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
          withdrawApplicationStatus: WithdrawApplicationStatus.init,
        ),
      ],
    );

    // Add similar blocTest blocks for other events: LoadApprovedApplications, LoadRejectedApplications
  });
}
