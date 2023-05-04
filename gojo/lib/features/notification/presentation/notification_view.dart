import 'package:flutter/material.dart';

import '../../../Gojo-Mobile-Shared/UI/list_items/gojo_notifcation_item.dart';
import '../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: SingleChildScrollView(
        child: Column(
          children: const [
            GojoNotificationItem(
              isAppointment: false,
              title: "Nabek Abebe",
              subtitle: "Paid 10,0000 Birrs for Kidus",
            ),
            GojoNotificationItem(
              isAppointment: false,
              title: "Kidus Yoseph",
              subtitle: "Approved an appoinment for Mar 27 at 8:00 AM",
            ),
            GojoNotificationItem(
              isAppointment: false,
              title: "Lingerew Getie",
              subtitle: "The home you wanted is now available",
            ),
          ],
        ),
      ),
    );
  }
}
