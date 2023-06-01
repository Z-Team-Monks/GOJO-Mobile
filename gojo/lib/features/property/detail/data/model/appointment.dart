class AppointmentModel {
  final String propertyId;
  final String date;
  final String timeSlot;

  AppointmentModel({
    required this.propertyId,
    required this.date,
    required this.timeSlot,
  });

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": timeSlot,
      };
}
