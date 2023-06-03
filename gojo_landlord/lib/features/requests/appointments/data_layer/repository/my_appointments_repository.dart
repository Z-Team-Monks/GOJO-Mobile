import '../model/appointment.dart';
import 'my_appointments_client.dart';

abstract class MyAppointmentsRepositoryAPI {
  Future<List<Appointment>> getMyAppointments(int propertyId);
  Future<void> cancelAppointment(int id);
  Future<void> approveAppointment(int id);
}

class MyAppointmentsRepositoryImpl implements MyAppointmentsRepositoryAPI {
  MyAppointmentsClientAPI myAppointmentsClientAPI;

  MyAppointmentsRepositoryImpl(this.myAppointmentsClientAPI);

  @override
  Future<List<Appointment>> getMyAppointments(int propertyId) async {
    return await myAppointmentsClientAPI.getMyAppointments(propertyId);
  }

  @override
  Future<void> cancelAppointment(int id) async {
    myAppointmentsClientAPI.cancelAppointment(id);
  }

  @override
  Future<void> approveAppointment(int id) async {
    myAppointmentsClientAPI.approveAppointment(id);
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
  Future<List<Appointment>> getMyAppointments(int propertyId) {
    return Future.delayed(const Duration(seconds: 1), () => fakeAppointments);
  }

  @override
  Future<void> cancelAppointment(int id) async {
    await Future.delayed(const Duration(seconds: 2), () {
      fakeAppointments.removeWhere((element) => element.id == id);
    });
  }

  @override
  Future<void> approveAppointment(int id) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
