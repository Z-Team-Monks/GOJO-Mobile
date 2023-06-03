import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Gojo-Mobile-Shared/core/model/application.dart';
import '../../../../../Gojo-Mobile-Shared/core/repository/application/application_repository.dart';

part 'applications_event.dart';
part 'applications_state.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final ApplicationsRepositoryAPI applicationRepository;
  final int propertyId;

  ApplicationsBloc({
    required this.applicationRepository,
    required this.propertyId,
  }) : super(ApplicationsState.initial()) {
    on<LoadApplications>((event, emit) async {
      emit(state.copyWith(
        fetchApplicationsFetchStatus: FetchApplicationsStatus.loading,
      ));
      try {
        final pendingApplicationRequestItems = await applicationRepository
            .getPendingApplications(propertyId: propertyId);

        emit(state.copyWith(
          pendingApplications: pendingApplicationRequestItems,
          fetchApplicationsFetchStatus: FetchApplicationsStatus.loaded,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          fetchApplicationsFetchStatus: FetchApplicationsStatus.error,
        ));
      }
    });

    on<ContractFileChanged>((event, emit) {
      emit(state.copyWith(
        contractFilePath: event.path,
      ));
    });

    on<ApprovePendingApplication>((event, emit) async {
      emit(state.copyWith(
        approveApplicationStatus: ApproveApplicationStatus.loading,
      ));
      try {
        await applicationRepository.approvePendingApplication(
          pendingApplicationId: event.applicationId,
          contractFilePath: event.contractFilePath,
        );
        emit(state.copyWith(
          approveApplicationStatus: ApproveApplicationStatus.success,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          approveApplicationStatus: ApproveApplicationStatus.error,
        ));
      }
    });

    on<RejectPendingApplication>((event, emit) async {
      try {
        emit(state.copyWith(
          rejectApplicationStatus: RejectApplicationStatus.loading,
        ));
        await applicationRepository.withdrawPendingApplication(
          event.applicationId,
        );
        final updatedPendingApplications = state.pendingApplications
            .where((element) => element.id != event.applicationId)
            .toList();
        emit(state.copyWith(
          pendingApplications: updatedPendingApplications,
          rejectApplicationStatus: RejectApplicationStatus.success,
        ));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          rejectApplicationStatus: RejectApplicationStatus.error,
        ));
      }
    });
  }
}
