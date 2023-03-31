import 'package:flutter/material.dart';
import '../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../Gojo-Mobile-Shared/UI/list_items/gojo_notifcation_item.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GojoNotificationItem(
              isAppointment: false,
              title: "Nabek Abebe",
              subtitle: "Withdrew 10,0000 Birrs",
            ),
            GojoNotificationItem(
              isAppointment: true,
              title: "Kidus Yoseph",
              subtitle: "Scheduled an appointment for Mar 27 at 8:00 AM",
            ),
            GojoNotificationItem(
              isAppointment: false,
              title: "Lingerew Getie",
              subtitle: "Applied for a rent",
            ),
          ],
        ),
      ),
    );
  }
}
