class Appointment {
  final String id;
  final String fullName;
  final String date;
  final String phoneNumber;

  Appointment({
    required this.id,
    required this.fullName,
    required this.date,
    required this.phoneNumber,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      fullName: json['fullName'],
      date: json['date'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
