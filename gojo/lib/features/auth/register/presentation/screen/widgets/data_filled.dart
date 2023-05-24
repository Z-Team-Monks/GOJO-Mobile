import 'package:flutter/material.dart';

import '../../../../../../Gojo-Mobile-Shared/resources/resources.dart';

class DataFilled extends StatelessWidget {
  const DataFilled({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Resources.gojoColors.primaryColor,
          ),
        ),
        Text(
          value,
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
        const Divider(),
      ],
    );
  }
}
