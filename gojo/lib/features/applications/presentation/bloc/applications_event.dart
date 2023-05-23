part of 'applications_bloc.dart';

@immutable
abstract class ApplicationsEvent {}

class LoadApplications extends ApplicationsEvent {}

class LoadPendingApplications extends ApplicationsEvent {}

class LoadApprovedApplications extends ApplicationsEvent {}

class LoadRejectedApplications extends ApplicationsEvent {}

class WithdrawPendingApplication extends ApplicationsEvent {
  final int applicationId;

  WithdrawPendingApplication(this.applicationId);
}
