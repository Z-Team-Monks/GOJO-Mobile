import 'package:flutter/material.dart';

import '../../../../core/model/user.dart';

class HostAvatar extends StatelessWidget {
  final User owner;
  const HostAvatar({Key? key, required this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/sofa.jpeg'),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Host",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 10),
                const Icon(Icons.gite),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              "${owner.firstName} ${owner.lastName}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ],
    );
  }
}
