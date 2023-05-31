part of 'applications_bloc.dart';

@immutable
abstract class ApplicationsEvent {}

class LoadApplications extends ApplicationsEvent {}

class ContractFileChanged extends ApplicationsEvent {
  final String path;

  ContractFileChanged({required this.path});
}

class ApprovePendingApplication extends ApplicationsEvent {
  final int applicationId;

  ApprovePendingApplication(this.applicationId);
}

class RejectPendingApplication extends ApplicationsEvent {
  final int applicationId;

  RejectPendingApplication(this.applicationId);
}
