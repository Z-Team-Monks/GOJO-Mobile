import 'package:gojo/features/appointments/data_layer/repository/my_appointments_client.dart';

import '../model/appointment.dart';

abstract class MyAppointmentsRepositoryAPI {
  Future<List<Appointment>> getMyAppointments();
  Future<void> cancelAppointment(int id);
}

class MyAppointmentsRepositoryImpl implements MyAppointmentsRepositoryAPI {
  MyAppointmentsClientAPI myAppointmentsClientAPI;

  MyAppointmentsRepositoryImpl(this.myAppointmentsClientAPI);

  @override
  Future<List<Appointment>> getMyAppointments() async {
    return await myAppointmentsClientAPI.getMyAppointments();
  }

  @override
  Future<void> cancelAppointment(int id) async {
    myAppointmentsClientAPI.cancelAppointment(id);
  }
}

class MyAppointmentsRepositoryFake implements MyAppointmentsRepositoryAPI {
  final fakeAppointments = [
    Appointment(
      phoneNumber: "0911234532",
      id: 1,
      status: "pending",
      fullName: "Braha Marlam Roh I",
      date: "March 21, 2023",
    ),
    Appointment(
      phoneNumber: "0911234532",
      id: 2,
      status: "approved",
      fullName: "Braha Marlam Roh II",
      date: "March 21, 2023",
    ),
    Appointment(
      phoneNumber: "0911234532",
      id: 3,
      status: "pending",
      fullName: "Braha Marlam Roh III ",
      date: "March 21, 2023",
    ),
    Appointment(
      phoneNumber: "0911234532",
      id: 4,
      status: "approved",
      fullName: "Braha Marlam Roh IV",
      date: "March 21, 2023",
    ),
  ];

  @override
  Future<List<Appointment>> getMyAppointments() {
    return Future.delayed(const Duration(seconds: 1), () => fakeAppointments);
  }

  @override
  Future<void> cancelAppointment(int id) async {
    await Future.delayed(const Duration(seconds: 2), () {
      fakeAppointments.removeWhere((element) => element.id == id);
    });
  }
}
