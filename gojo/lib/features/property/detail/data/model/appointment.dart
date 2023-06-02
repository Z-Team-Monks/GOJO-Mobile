

class AppointmentModel {
  final int propertyId;
  final String date;
  final String timeSlot;

  AppointmentModel({
    required this.propertyId,
    required this.date,
    required this.timeSlot,
  });

  Map<String, dynamic> toJson() => {
        "appointment_date": date,
        "appointment_time": timeSlot,
      };
}
