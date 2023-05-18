import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
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
                const [_Header()],
                addRepaintBoundaries: false,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                padding: const EdgeInsets.all(GojoPadding.large),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.filled(
                        5,
                        const _ExpandableView(
                          fullName: "Braha Marlam Roh",
                          date: "Jan 2, 2023",
                          phoneNumber: "0955211643",
                        )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}

class _ExpandableView extends StatelessWidget {
  final String fullName;
  final String date;
  final String phoneNumber;

  const _ExpandableView({
    super.key,
    required this.fullName,
    required this.date,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
          ),
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(fullName),
              Text(date),
            ],
          ),
          collapsed: Container(),
          expanded: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(phoneNumber),
                const SizedBox(height: 15),
                GojoBarButton(
                  customHeight: 40,
                  title: "Withdraw Appointment",
                  onClick: () {},
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
