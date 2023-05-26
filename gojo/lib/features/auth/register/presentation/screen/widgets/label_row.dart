import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';

class LabelRow extends StatelessWidget {
  const LabelRow({
    super.key,
    required this.step,
    required this.title,
    required this.isSelected,
  });

  final int step;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          maxRadius: 15,
          backgroundColor: isSelected
              ? Colors.white
              : const Color.fromARGB(90, 255, 255, 255),
          foregroundColor:
              isSelected ? Resources.gojoColors.primaryColor : Colors.white,
          child: Text("$step"),
        ),
        const SizedBox(width: 20),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
