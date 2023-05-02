import 'package:flutter/material.dart';

class PageViewTab extends StatelessWidget {
  const PageViewTab({
    super.key,
    required this.label,
    required this.onSelected,
    required this.isSelected,
  });

  final String label;
  final Function(String? p1) onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(label),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 4,
        ),
        decoration: isSelected
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2),
                ),
              )
            : null,
        child: Text(
          label,
        ),
      ),
    );
  }
}
