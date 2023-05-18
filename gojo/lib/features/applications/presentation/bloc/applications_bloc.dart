import 'package:bloc/bloc.dart';
import 'package:gojo/features/applications/data_layer/repository/application_repository.dart';
import 'package:gojo/features/applications/presentation/model/application_status.dart';
import 'package:gojo/features/applications/presentation/screen/widgets/application_request_item.dart';
import 'package:meta/meta.dart';

part 'applications_event.dart';
part 'applications_state.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final ApplicationsRepositoryAPI applicationRepository;

  ApplicationsBloc(this.applicationRepository)
      : super(ApplicationsState.initial()) {
    on<LoadApplications>((event, emit) async {
      emit(state.copyWith(
        pendingApplicationsFetchStatus: FetchApplicationsStatus.loading,
        approvedApplicationsFetchStatus: FetchApplicationsStatus.loading,
        rejectedApplicationsFetchStatus: FetchApplicationsStatus.loading,
      ));

      try {
        final pendingApplicationRequestItems =
            await _loadPendingApplicationRequestItems();

        emit(state.copyWith(
          pendingApplications: pendingApplicationRequestItems,
          pendingApplicationsFetchStatus: FetchApplicationsStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          pendingApplicationsFetchStatus: FetchApplicationsStatus.error,
        ));
      }

      try {
        final approvedApplicationRequestItems =
            await _loadApprovedApplicationRequestItems();

        emit(state.copyWith(
          approvedApplications: approvedApplicationRequestItems,
          approvedApplicationsFetchStatus: FetchApplicationsStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
          approvedApplicationsFetchStatus: FetchApplicationsStatus.error,
        ));
      }

      try {
        final rejectedApplicationRequestItems =
            await _loadRejectedApplicationRequestItems();

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

  Future<List<ApplicationRequestItem>>
      _loadPendingApplicationRequestItems() async {
    final pendingApplications =
        await applicationRepository.getPendingApplications();
    return pendingApplications
        .map((application) => ApplicationRequestItem(
              title: application.title,
              leadingImageUrl: application.thumbnailUrl,
              description: application.description,
              status: ApplicationStatusType.pending,
              topRightDate: application.applicationDate,
              startDate: application.startDate,
              endDate: application.endDate,
            ))
        .toList();
  }

  Future<List<ApplicationRequestItem>>
      _loadApprovedApplicationRequestItems() async {
    final approvedApplications =
        await applicationRepository.getApprovedApplications();
    return approvedApplications
        .map((application) => ApplicationRequestItem(
              title: application.title,
              leadingImageUrl: application.thumbnailUrl,
              description: application.description,
              status: ApplicationStatusType.approved,
              topRightDate: application.applicationDate,
              startDate: application.startDate,
              endDate: application.endDate,
            ))
        .toList();
  }

  Future<List<ApplicationRequestItem>>
      _loadRejectedApplicationRequestItems() async {
    final rejectedApplications =
        await applicationRepository.getRejectedApplications();
    return rejectedApplications
        .map((application) => ApplicationRequestItem(
              title: application.title,
              leadingImageUrl: application.thumbnailUrl,
              description: application.description,
              status: ApplicationStatusType.rejected,
              topRightDate: application.applicationDate,
              startDate: application.startDate,
              endDate: application.endDate,
            ))
        .toList();
  }
}
