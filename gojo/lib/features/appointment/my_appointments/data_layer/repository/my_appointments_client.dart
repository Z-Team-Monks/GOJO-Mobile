import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import 'package:gojo/features/appointment/my_appointments/data_layer/model/appointment.dart';

abstract class MyAppointmentsClientAPI {
  Future<List<Appointment>> getMyAppointments();

  Future<void> cancelAppointment(String id);
}

class MyAppointmemtsClientImpl extends BaseApiClient
    implements MyAppointmentsClientAPI {
  @override
  Future<List<Appointment>> getMyAppointments() async {
    final myAppointmentsResponse = await get("/appointments");
    return (myAppointmentsResponse.data as List)
        .map((e) => Appointment.fromJson(e))
        .toList();
  }

  @override
  Future<void> cancelAppointment(String id) async {
    delete("/appointments/$id");
  }
}
