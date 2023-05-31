class Appointment {
  final int id;
  final String fullName;
  final String date;
  final String status;
  final String phoneNumber;

  Appointment({
    required this.id,
    required this.fullName,
    required this.date,
    required this.phoneNumber,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      fullName: json['landlord_full_name'],
      date: json['date'],
      phoneNumber: json['landlord_phone'],
      status: json['status'],
    );
  }
}
