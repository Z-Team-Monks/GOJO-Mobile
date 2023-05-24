class ApplyForRentModel {
  final DateTime startDate;
  final int? months;
  final String? message;
  final String propertyId;

  ApplyForRentModel({
    required this.startDate,
    this.months,
    this.message,
    required this.propertyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate.toIso8601String(),
      'months': months ?? 2,
      'message': message ?? "",
    };
  }
}
