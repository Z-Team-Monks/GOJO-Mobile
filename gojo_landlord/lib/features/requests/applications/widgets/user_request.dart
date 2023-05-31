import 'package:flutter/material.dart';
import 'package:gojo_landlord/features/requests/applications/widgets/text_button.dart';

import '../../../../Gojo-Mobile-Shared/resources/resources.dart';

class UserRequest extends StatelessWidget {
  const UserRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(
                        Resources.gojoImages.headShot,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Kodak Yellow",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
                const Text("March 2, 2023")
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Text("Date:"),
                const SizedBox(width: 4),
                Text(
                  "Jan 4,2023 - Mar 4,2023",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation",
              maxLines: 3,
              overflow: TextOverflow.fade,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GojoTextButton(
                    label: "Reject",
                    onPressed: () {},
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GojoTextButton(
                    label: "Approve",
                    onPressed: () {},
                    color: Resources.gojoColors.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
