import 'package:flutter/material.dart';

class PropertyInfoRow extends StatelessWidget {
  const PropertyInfoRow({
    super.key,
    required this.context,
    required this.icon,
    required this.description,
  });

  final BuildContext context;
  final IconData icon;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 16,
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
