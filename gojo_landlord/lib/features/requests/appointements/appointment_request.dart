import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/resources/resources.dart';

class AppointmentRequest extends StatelessWidget {
  const AppointmentRequest({super.key});

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
                    const SizedBox(
                      width: 12,
                    ),
                    const Text("Kodak Yellow")
                  ],
                ),
                const Text("12:00 am")
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Reject"))),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Approve")))
              ],
            )
          ],
        ),
      ),
    );
  }
}