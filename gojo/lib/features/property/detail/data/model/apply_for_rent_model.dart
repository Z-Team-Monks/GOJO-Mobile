import 'package:intl/intl.dart';

class ApplyForRentModel {
  final DateTime startDate;
  final int? months;
  final String? message;
  final int propertyId;

  ApplyForRentModel({
    required this.startDate,
    this.months,
    this.message,
    required this.propertyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'property_id': propertyId,
      'possible_start_date': DateFormat("yyyy-MM-dd").format(startDate),
      'how_long': months ?? 2,
      'description': message ?? "",
    };
  }
}
