import 'package:flutter/material.dart';
import 'package:gojo/constants/strings/app_routes.dart';

import '../../../../core/model/user.dart';

class HostAvatar extends StatelessWidget {
  final User owner;
  const HostAvatar({Key? key, required this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 0.6,
        ),
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/sofa.jpeg'),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              children: [
                Row(
                  children: const [
                    Text("Owner"),
                    SizedBox(width: 10),
                    Icon(Icons.account_circle),
                  ],
                ),
                Text(
                  "${owner.firstName} ${owner.lastName}",
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Row(
              children: [
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.remove_red_eye),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, GojoRoutes.virtualTour);
                  },
                ),
                const SizedBox(width: 8),
              ],
            )
          ],
        ),
        const Divider(
          thickness: 0.6,
        ),
      ],
    );
  }
}
