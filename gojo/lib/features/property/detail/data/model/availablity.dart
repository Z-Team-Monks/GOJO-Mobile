class AvailabilityModel {
  List<int> days;
  final Map<String, List<String>> timeSlots;

  AvailabilityModel({required this.days, required this.timeSlots});

  AvailabilityModel copyWith({
    List<int>? days,
    Map<String, List<String>>? timeSlots,
  }) {
    return AvailabilityModel(
      days: days ?? this.days,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }

  factory AvailabilityModel.fromMap(Map<String, dynamic> map) {
    return AvailabilityModel(
      days: List<int>.from(map['days']),
      timeSlots: Map<String, List<String>>.from(map['timeSlots']),
    );
  }
}
