import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';

import '../../../../core/repository/user_repository.dart';
import '../model/appointment.dart';

abstract class MyAppointmentsClientAPI {
  Future<List<Appointment>> getMyAppointments();

  Future<void> cancelAppointment(int id);
}

class MyAppointmemtsClientImpl extends BaseApiClient
    implements MyAppointmentsClientAPI {
  @override
  Future<List<Appointment>> getMyAppointments() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final myAppointmentsResponse = await get(
      "appointments/",
      token: user.token,
    );
    debugPrint(myAppointmentsResponse.data['results'].toString());
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
}
