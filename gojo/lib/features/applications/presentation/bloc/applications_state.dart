part of 'applications_bloc.dart';

enum FetchApplicationsStatus { loading, loaded, error }

enum WithdrawApplicationStatus { init, loading, success, error }

class ApplicationsState extends Equatable {
  final List<Application> pendingApplications;
  final List<Application> approvedApplications;
  final List<Application> rejectedApplications;
  final FetchApplicationsStatus pendingApplicationsFetchStatus;
  final FetchApplicationsStatus approvedApplicationsFetchStatus;
  final FetchApplicationsStatus rejectedApplicationsFetchStatus;
  final WithdrawApplicationStatus withdrawApplicationStatus;

  const ApplicationsState(
      {required this.pendingApplications,
      required this.approvedApplications,
      required this.rejectedApplications,
      required this.pendingApplicationsFetchStatus,
      required this.approvedApplicationsFetchStatus,
      required this.withdrawApplicationStatus,
      required this.rejectedApplicationsFetchStatus});

  factory ApplicationsState.initial() {
    return const ApplicationsState(
      pendingApplications: [],
      approvedApplications: [],
      rejectedApplications: [],
      pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
      approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
      rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
      withdrawApplicationStatus: WithdrawApplicationStatus.init,
    );
  }

  ApplicationsState copyWith({
    List<Application>? pendingApplications,
    List<Application>? approvedApplications,
    List<Application>? rejectedApplications,
    FetchApplicationsStatus? pendingApplicationsFetchStatus,
    FetchApplicationsStatus? approvedApplicationsFetchStatus,
    FetchApplicationsStatus? rejectedApplicationsFetchStatus,
    WithdrawApplicationStatus? withdrawApplicationStatus,
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
      withdrawApplicationStatus:
          withdrawApplicationStatus ?? this.withdrawApplicationStatus,
    );
  }

  @override
  List<Object?> get props => [
        pendingApplications,
        approvedApplications,
        rejectedApplications,
        pendingApplicationsFetchStatus,
        approvedApplicationsFetchStatus,
        rejectedApplicationsFetchStatus,
        withdrawApplicationStatus,
      ];
}
