import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/appointment.dart';

abstract class MyAppointmentsClientAPI {
  Future<List<Appointment>> getMyAppointments(int propertyId);

  Future<void> cancelAppointment(int id);

  Future<void> approveAppointment(int id);
}

class MyAppointmemtsClientImpl extends BaseApiClient
    implements MyAppointmentsClientAPI {
  @override
  Future<List<Appointment>> getMyAppointments(int propertyId) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final myAppointmentsResponse = await get(
      "appointments/?propertyId=$propertyId",
      token: user.token,
    );

    return (myAppointmentsResponse.data['results'] as List)
        .map((e) => Appointment.fromJson(e))
        .toList();
  }

  @override
  Future<void> cancelAppointment(int id) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    delete("appointments/$id/cancel/", token: user.token);
  }

  @override
  Future<void> approveAppointment(int id) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    post("appointments/$id/approve/", token: user.token, null);
  }
}
