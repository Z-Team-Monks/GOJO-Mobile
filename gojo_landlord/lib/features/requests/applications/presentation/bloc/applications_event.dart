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
  final String contractFilePath;

  ApprovePendingApplication({
    required this.applicationId,
    required this.contractFilePath,
  });
}

class RejectPendingApplication extends ApplicationsEvent {
  final int applicationId;

  RejectPendingApplication(this.applicationId);
}
