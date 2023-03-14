import 'package:flutter/material.dart';

class PropertyDescription extends StatelessWidget {
  final int itemCount;
  final String label;
  final IconData iconData;
  const PropertyDescription({Key? key, required this.iconData, required this.label, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: Colors.grey[600],),
        const SizedBox(width: 4,),
        Text("$itemCount $label", style: Theme.of(context).textTheme.bodySmall,)
      ],
    );
  }
}
