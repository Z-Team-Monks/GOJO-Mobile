import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/application/application_repository.dart';
import '../bloc/applications_bloc.dart';
import '../model/application_status.dart';
import 'widgets/application_request_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: AppLocalizations.of(context)!.applicationRequests,
      child: BlocProvider(
        create: (context) =>
            ApplicationsBloc(GetIt.I<ApplicationsRepositoryAPI>())
              ..add(LoadApplications()),
        child: const ApplicationsTabView(),
      ),
    );
  }
}

class ApplicationsTabView extends StatelessWidget {
  const ApplicationsTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApplicationsBloc, ApplicationsState>(
      listener: (context, state) {
        switch (state.withdrawApplicationStatus) {
          case WithdrawApplicationStatus.loading:
            GojoSnackBars.showLoading(
                context, AppLocalizations.of(context)!.withdrawingApplicaiton);
            break;
          case WithdrawApplicationStatus.success:
            GojoSnackBars.showSuccess(
                context, AppLocalizations.of(context)!.applicationWithdrawn);
            break;
          case WithdrawApplicationStatus.error:
            GojoSnackBars.showError(context,
                AppLocalizations.of(context)!.couldntWithdrawApplication);
            break;
          default:
            break;
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context)!.pending),
                Tab(text: AppLocalizations.of(context)!.approved),
                Tab(text: AppLocalizations.of(context)!.rejected),
              ],
            ),
            const SizedBox(height: 8),
            const Expanded(
              child: TabBarView(
                children: [
                  PendingApplicationsTab(),
                  ApprovedApplicationsTab(),
                  RejectedApplicationsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PendingApplicationsTab extends StatelessWidget {
  const PendingApplicationsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationsBloc, ApplicationsState>(
      builder: (context, state) {
        switch (state.pendingApplicationsFetchStatus) {
          case FetchApplicationsStatus.loaded:
            if (state.pendingApplications.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child:
                      Text(AppLocalizations.of(context)!.noPendingApplications),
                ),
              );
            }
            return ListView(
              children: state.pendingApplications
                  .map((application) => ApplicationRequestItem(
                        leadingImageUrl: application.thumbnailUrl,
                        title: application.title,
                        status: ApplicationStatusType.pending,
                        topRightDate: application.applicationDate,
                        startDate: application.startDate,
                        endDate: application.endDate,
                        description: application.description,
                        onWithDraw: () {
                          context
                              .read<ApplicationsBloc>()
                              .add(WithdrawPendingApplication(application.id));
                        },
                      ))
                  .toList(),
            );
          case FetchApplicationsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchApplicationsStatus.error:
            return Center(
                child: Text(AppLocalizations.of(context)!.errorLoadingContent));
        }
      },
    );
  }
}

class ApprovedApplicationsTab extends StatelessWidget {
  const ApprovedApplicationsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationsBloc, ApplicationsState>(
      builder: (context, state) {
        switch (state.approvedApplicationsFetchStatus) {
          case FetchApplicationsStatus.loaded:
            if (state.approvedApplications.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(
                      AppLocalizations.of(context)!.noApprovedApplications),
                ),
              );
            }
            return ListView(
              children: state.approvedApplications
                  .map((application) => ApplicationRequestItem(
                        leadingImageUrl: application.thumbnailUrl,
                        title: application.title,
                        status: ApplicationStatusType.approved,
                        topRightDate: application.applicationDate,
                        startDate: application.startDate,
                        endDate: application.endDate,
                        description: application.description,
                      ))
                  .toList(),
            );
          case FetchApplicationsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchApplicationsStatus.error:
            return Center(
              child: Text(AppLocalizations.of(context)!.errorLoadingContent),
            );
        }
      },
    );
  }
}

class RejectedApplicationsTab extends StatelessWidget {
  const RejectedApplicationsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationsBloc, ApplicationsState>(
      builder: (context, state) {
        switch (state.rejectedApplicationsFetchStatus) {
          case FetchApplicationsStatus.loaded:
            if (state.rejectedApplications.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.noRejectedApplications,
                  ),
                ),
              );
            }
            return ListView(
              children: state.rejectedApplications
                  .map((application) => ApplicationRequestItem(
                        leadingImageUrl: application.thumbnailUrl,
                        title: application.title,
                        status: ApplicationStatusType.rejected,
                        topRightDate: application.applicationDate,
                        startDate: application.startDate,
                        endDate: application.endDate,
                        description: application.description,
                      ))
                  .toList(),
            );
          case FetchApplicationsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchApplicationsStatus.error:
            return Text(AppLocalizations.of(context)!.errorLoadingContent);
        }
      },
    );
  }
}
