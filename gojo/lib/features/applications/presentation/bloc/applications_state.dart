part of 'applications_bloc.dart';

enum FetchApplicationsStatus { loading, loaded, error }

class ApplicationsState {
  final List<ApplicationRequestItem> pendingApplications;
  final List<ApplicationRequestItem> approvedApplications;
  final List<ApplicationRequestItem> rejectedApplications;
  final FetchApplicationsStatus pendingApplicationsFetchStatus;
  final FetchApplicationsStatus approvedApplicationsFetchStatus;
  final FetchApplicationsStatus rejectedApplicationsFetchStatus;

  const ApplicationsState(
      {required this.pendingApplications,
      required this.approvedApplications,
      required this.rejectedApplications,
      required this.pendingApplicationsFetchStatus,
      required this.approvedApplicationsFetchStatus,
      required this.rejectedApplicationsFetchStatus});

  factory ApplicationsState.initial() {
    return const ApplicationsState(
      pendingApplications: [],
      approvedApplications: [],
      rejectedApplications: [],
      pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
      approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
      rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
    );
  }

  ApplicationsState copyWith({
    List<ApplicationRequestItem>? pendingApplications,
    List<ApplicationRequestItem>? approvedApplications,
    List<ApplicationRequestItem>? rejectedApplications,
    FetchApplicationsStatus? pendingApplicationsFetchStatus,
    FetchApplicationsStatus? approvedApplicationsFetchStatus,
    FetchApplicationsStatus? rejectedApplicationsFetchStatus,
  }) {
    return ApplicationsState(
      pendingApplications: pendingApplications ?? this.pendingApplications,
      approvedApplications: approvedApplications ?? this.approvedApplications,
      rejectedApplications: rejectedApplications ?? this.rejectedApplications,
      pendingApplicationsFetchStatus:
          pendingApplicationsFetchStatus ?? this.pendingApplicationsFetchStatus,
      approvedApplicationsFetchStatus: approvedApplicationsFetchStatus ??
          this.approvedApplicationsFetchStatus,
      rejectedApplicationsFetchStatus: rejectedApplicationsFetchStatus ??
          this.rejectedApplicationsFetchStatus,
    );
  }
}
