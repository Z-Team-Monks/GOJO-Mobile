import 'package:flutter/material.dart';

enum ApplicationStatusType {
  pending,
  approved,
  rejected,
}

extension ApplicationStatusTypeExtension on ApplicationStatusType {
  String get title {
    switch (this) {
      case ApplicationStatusType.pending:
        return "Pending";
      case ApplicationStatusType.approved:
        return "Approved";
      case ApplicationStatusType.rejected:
        return "Rejected";
    }
  }

  Color get color {
    switch (this) {
      case ApplicationStatusType.pending:
        return Colors.green.withOpacity(0.5);
      case ApplicationStatusType.approved:
        return Colors.green;
      case ApplicationStatusType.rejected:
        return Colors.red;
    }
  }
}

class ApplicationStatus extends StatelessWidget {
  final ApplicationStatusType type;
  const ApplicationStatus({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: type.color,
      ),
      child: Text(
        type.title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
