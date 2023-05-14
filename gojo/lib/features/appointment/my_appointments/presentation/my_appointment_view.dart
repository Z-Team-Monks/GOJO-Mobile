import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class MyAppointmentsView extends StatelessWidget {
  const MyAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
        label: "My Appointments",
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [_buildHeader(context)],
                addRepaintBoundaries: false,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildExpandableView(context),
                      Divider(),
                      _buildExpandableView(context),
                      Divider(),
                      _buildExpandableView(context),
                      Divider(),
                      _buildExpandableView(context),
                      Divider(),
                      _buildExpandableView(context),
                      Divider(),
                      _buildExpandableView(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Column _buildHeader(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Full Name",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 16,
                  ),
            ),
            Text(
              "Date",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildExpandableView(BuildContext context) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
      ),
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Braha Marlam Roh"),
          Text("Jan 2, 20223"),
        ],
      ),
      collapsed: Container(),
      expanded: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phone: 0955211643"),
            const SizedBox(height: 15),
            GojoBarButton(
              customHeight: 40,
              title: "Withdraw Appointment",
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
