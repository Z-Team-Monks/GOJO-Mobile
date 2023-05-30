import 'package:intl/intl.dart';

import 'address.dart';
import 'category.dart';
import 'facility.dart';
import 'visiting_hour.dart';

class NewProperty {
  final String title;
  final String description;
  final double amount;
  final DateTime startDate;
  final List<Facility> facilities;
  final Category category;
  final Address address;
  final WeeklyVisitingHours weeklyVisitingHour;

  NewProperty({
    required this.title,
    required this.description,
    required this.amount,
    required this.startDate,
    required this.facilities,
    required this.category,
    required this.address,
    required this.weeklyVisitingHour,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'description': description,
      'start_date': DateFormat('yyyy-MM-dd').format(startDate),
      'facilities': facilities.map((e) => e.toJson()).toList(),
      'category': category.toJson(),
      'address': address.toJson(),
      'visiting_hours': weeklyVisitingHour.toJson(),
    };
  }
}
