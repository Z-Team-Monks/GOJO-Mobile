import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/features/applications/data_layer/repository/application_repository.dart';
import 'package:gojo/features/applications/presentation/bloc/applications_bloc.dart';
import 'package:gojo/features/applications/presentation/model/application_status.dart';
import 'package:gojo/features/applications/presentation/screen/widgets/application_request_item.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Application requests",
      child: BlocProvider(
        create: (context) =>
            ApplicationsBloc(GetIt.I<ApplicationsRepositoryAPI>())
              ..add(
                LoadApplications(),
              ),
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
    return DefaultTabController(
      length: 3,
      child: Column(
        children: const [
          TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Approved"),
              Tab(text: "Rejected"),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
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
            return ListView(
              children: state.pendingApplications,
            );
          case FetchApplicationsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchApplicationsStatus.error:
            return const Center(child: Text("Error"));
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
            return ListView(
              children: state.approvedApplications,
            );
          case FetchApplicationsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchApplicationsStatus.error:
            return const Center(child: Text("Error"));
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
            return ListView(
              children: state.rejectedApplications,
            );
          case FetchApplicationsStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FetchApplicationsStatus.error:
            return const Center(child: Text("Error"));
        }
      },
    );
  }
}
