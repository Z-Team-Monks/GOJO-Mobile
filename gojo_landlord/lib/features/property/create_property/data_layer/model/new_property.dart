import 'address.dart';
import 'category.dart';
import 'facility.dart';

class NewProperty {
  final DateTime startDate;
  final DateTime endDate;
  final List<Facility> facilities;
  final Category category;
  final Address address;

  NewProperty({
    required this.startDate,
    required this.endDate,
    required this.facilities,
    required this.category,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'facilities': facilities.map((e) => e.toJson()).toList(),
      'category': category.toJson(),
      'address': address.toJson(),
    };
  }
}
