import 'package:bloc/bloc.dart';
import 'package:gojo/app.dart';
import 'package:gojo/features/applications/data_layer/model/application.dart';
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
        final pendingApplications =
            await applicationRepository.getPendingApplications();
        final pendingApplicationRequestItems = pendingApplications
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
        final approvedApplications =
            await applicationRepository.getApprovedApplications();
        final approvedApplicationRequestItems = approvedApplications
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
        final rejectedApplications =
            await applicationRepository.getRejectedApplications();
        final rejectedApplicationRequestItems = rejectedApplications
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
