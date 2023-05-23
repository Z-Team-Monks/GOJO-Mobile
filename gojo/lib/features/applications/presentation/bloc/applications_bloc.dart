import 'package:bloc/bloc.dart';
import 'package:gojo/features/applications/data_layer/model/application.dart';
import 'package:gojo/features/applications/data_layer/repository/application_repository.dart';
import 'package:meta/meta.dart';

part 'applications_event.dart';
part 'applications_state.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final ApplicationsRepositoryAPI applicationRepository;

  ApplicationsBloc(this.applicationRepository)
      : super(ApplicationsState.initial()) {
    on<LoadApplications>((event, emit) async {
      add(LoadPendingApplications());
      add(LoadApprovedApplications());
      add(LoadRejectedApplications());
    });

    on<WithdrawPendingApplication>(((event, emit) async {
      try {
        emit(state.copyWith(
          withdrawApplicationStatus: WithdrawApplicationStatus.loading,
        ));
        await applicationRepository
            .withdrawPendingApplication(event.applicationId);
        final updatedPendingApplications = state.pendingApplications
            .where((element) => element.id != event.applicationId)
            .toList();
        emit(state.copyWith(
          pendingApplications: updatedPendingApplications,
          withdrawApplicationStatus: WithdrawApplicationStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          withdrawApplicationStatus: WithdrawApplicationStatus.error,
        ));
      }
    }));

    on<LoadPendingApplications>((event, emit) async {
      emit(state.copyWith(
        pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
      ));
      try {
        final pendingApplicationRequestItems =
            await applicationRepository.getPendingApplications();

        emit(state.copyWith(
          pendingApplications: pendingApplicationRequestItems,
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          pendingApplicationsFetchStatus: FetchApplicationsStatus.error,
        ));
      }
    });

    on<LoadApprovedApplications>((event, emit) async {
      emit(state.copyWith(
        approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
      ));
      try {
        final approvedApplicationRequestItems =
            await applicationRepository.getApprovedApplications();

        emit(state.copyWith(
          approvedApplications: approvedApplicationRequestItems,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          approvedApplicationsFetchStatus: FetchApplicationsStatus.error,
        ));
      }
    });

    on<LoadRejectedApplications>((event, emit) async {
      emit(state.copyWith(
        rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
      ));
      try {
        final rejectedApplicationRequestItems =
            await applicationRepository.getRejectedApplications();

        emit(state.copyWith(
          rejectedApplications: rejectedApplicationRequestItems,
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          rejectedApplicationsFetchStatus: FetchApplicationsStatus.error,
        ));
      }
    });
  }
}
