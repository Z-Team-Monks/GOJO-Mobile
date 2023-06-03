part of 'applications_bloc.dart';

enum FetchApplicationsStatus { loading, loaded, error }

enum ApproveApplicationStatus { init, loading, success, error }

enum RejectApplicationStatus { init, loading, success, error }

class ApplicationsState {
  final List<Application> pendingApplications;
  final FetchApplicationsStatus fetchApplicationsFetchStatus;
  final ApproveApplicationStatus approveApplicationStatus;
  final RejectApplicationStatus rejectApplicationStatus;

  const ApplicationsState({
    required this.pendingApplications,
    required this.fetchApplicationsFetchStatus,
    required this.approveApplicationStatus,
    required this.rejectApplicationStatus,
  });

  factory ApplicationsState.initial() {
    return const ApplicationsState(
      pendingApplications: [],
      fetchApplicationsFetchStatus: FetchApplicationsStatus.loading,
      approveApplicationStatus: ApproveApplicationStatus.init,
      rejectApplicationStatus: RejectApplicationStatus.init,
    );
  }

  ApplicationsState copyWith({
    List<Application>? pendingApplications,
    FetchApplicationsStatus? fetchApplicationsFetchStatus,
    ApproveApplicationStatus? approveApplicationStatus,
    RejectApplicationStatus? rejectApplicationStatus,
    String? contractFilePath,
  }) {
    return ApplicationsState(
      pendingApplications: pendingApplications ?? this.pendingApplications,
      fetchApplicationsFetchStatus:
          fetchApplicationsFetchStatus ?? this.fetchApplicationsFetchStatus,
      approveApplicationStatus:
          approveApplicationStatus ?? this.approveApplicationStatus,
      rejectApplicationStatus:
          rejectApplicationStatus ?? this.rejectApplicationStatus,
    );
  }
}
