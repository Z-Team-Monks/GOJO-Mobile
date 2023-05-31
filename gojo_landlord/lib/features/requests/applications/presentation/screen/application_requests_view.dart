import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/core/repository/application/application_repository.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../bloc/applications_bloc.dart';
import 'widgets/application_request_item.dart';

class ApplicationRequestsView extends StatelessWidget {
  const ApplicationRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApplicationsBloc(
        GetIt.I<ApplicationsRepositoryAPI>(),
      )..add(LoadApplications()),
      child: const _ApplicationRequestsView(),
    );
  }
}

class _ApplicationRequestsView extends StatelessWidget {
  const _ApplicationRequestsView();

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Application Requests",
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 5; i++)
              ApplicationRequestItem(
                leadingImageUrl: Resources.gojoImages.headShot,
                title: "Kodak Yellow",
                topRightDate: "March 2, 2023",
                startDate: "Jan 4,2023",
                endDate: "Mar 4,2023",
                description:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation",
                onApprove: () {},
                onReject: () {},
              ),
          ],
        ),
      ),
    );
  }
}
