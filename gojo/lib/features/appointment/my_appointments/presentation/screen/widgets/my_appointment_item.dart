import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';

class MyAppointementsItem extends StatelessWidget {
  final String fullName;
  final String date;
  final String phoneNumber;
  final Function()? onCancel;

  const MyAppointementsItem({
    super.key,
    required this.fullName,
    required this.date,
    required this.phoneNumber,
    required this.onCancel,
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
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(phoneNumber),
                const SizedBox(height: 15),
                GojoBarButton(
                  customHeight: 40,
                  title: "Cancel ",
                  onClick: onCancel,
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
