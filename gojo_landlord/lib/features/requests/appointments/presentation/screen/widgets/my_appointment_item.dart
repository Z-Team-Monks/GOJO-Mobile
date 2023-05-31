import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';

enum AppointmentStatusType {
  pending,
  approved,
}

class MyAppointementsItem extends StatelessWidget {
  final String fullName;
  final String date;
  final String phoneNumber;
  final AppointmentStatusType status;
  final Function()? onClick;

  const MyAppointementsItem({
    super.key,
    required this.fullName,
    required this.date,
    required this.phoneNumber,
    required this.onClick,
    required this.status,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(fullName),
              Text(date),
            ],
          ),
          collapsed: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Status: ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 2),
              AppointmentStatus(type: status),
            ],
          ),
          expanded: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Status: ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 2),
                    AppointmentStatus(
                      type: status,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(phoneNumber),
                const SizedBox(height: 15),
                status == AppointmentStatusType.pending
                    ? GojoBarButton(
                        customHeight: 40,
                        title: "Approve",
                        onClick: onClick,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class AppointmentStatus extends StatelessWidget {
  final AppointmentStatusType type;
  const AppointmentStatus({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: type.color,
      ),
      child: Text(
        type.title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

extension AppointmentStatusTypeExtension on AppointmentStatusType {
  String get title {
    switch (this) {
      case AppointmentStatusType.pending:
        return "Pending";
      case AppointmentStatusType.approved:
        return "Approved";
    }
  }

  Color get color {
    switch (this) {
      case AppointmentStatusType.pending:
        return Colors.green.withOpacity(0.5);
      case AppointmentStatusType.approved:
        return Colors.green;
    }
  }
}
