import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/features/applications/presentation/screen/widgets/application_status.dart';
import 'package:gojo/features/applications/presentation/screen/widgets/expandable_panel.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Application requests",
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: "Pending"),
                Tab(text: "Rejected"),
                Tab(text: "Approved"),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: List.filled(
                      3,
                      const ApplicationExpandablePanel(
                        leadingImageUrl: "",
                        title: "Application title",
                        status: ApplicationStatusType.pending,
                        topRightDate: "March 2, 2023",
                        startDate: "Jan 4, 2023",
                        endDate: "Jan 4, 2024",
                        description: "Application description",
                      ),
                    ),
                  ),
                  ListView(
                    children: List.filled(
                      2,
                      const ApplicationExpandablePanel(
                        leadingImageUrl: "",
                        title: "Application title",
                        status: ApplicationStatusType.rejected,
                        topRightDate: "March 2, 2023",
                        startDate: "Jan 4, 2023",
                        endDate: "Jan 4, 2024",
                        description: "Application description",
                      ),
                    ),
                  ),
                  ListView(
                    children: List.filled(
                      1,
                      const ApplicationExpandablePanel(
                        leadingImageUrl: "",
                        title: "Application title",
                        status: ApplicationStatusType.approved,
                        topRightDate: "March 2, 2023",
                        startDate: "Jan 4, 2023",
                        endDate: "Jan 4, 2024",
                        description: "Application description",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
