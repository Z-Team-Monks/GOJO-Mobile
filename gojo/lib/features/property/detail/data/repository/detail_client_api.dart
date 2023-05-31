import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../../../../../core/repository/user_repository.dart';
import '../model/apply_for_rent_model.dart';
import '../model/appointment.dart';
import '../model/property.dart';

abstract class PropertyDetailClientAPI {
  Future<Property> fetchProperty(int propertyId);
  Future<void> scheduleAppointment(AppointmentModel appointment);
  Future<void> applyForRent(ApplyForRentModel applyForRentModel);
  Future<void> favorProperty(int propertyId);
  Future<void> unfavorProperty(int propertyId);
}

class PropertyDetailClientImpl extends BaseApiClient
    implements PropertyDetailClientAPI {
  @override
  Future<Property> fetchProperty(int propertyId) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final fetchPropertyResponse = await get(
      'properties/$propertyId/',
      token: user.token,
    );
    debugPrint(fetchPropertyResponse.data.toString());
    return Property.fromJson(fetchPropertyResponse.data);
  }

  @override
  Future<void> scheduleAppointment(AppointmentModel appointment) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    await post(
      'properties/${appointment.propertyId}/schedule_appointment/',
      appointment,
      token: user.token,
    );
  }

  @override
  Future<void> applyForRent(ApplyForRentModel applyForRentModel) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    await post(
      "properties/${applyForRentModel.propertyId}/apply_for_rent/",
      applyForRentModel.toJson(),
      token: user.token,
    );
  }

  @override
  Future<void> favorProperty(int propertyId) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    await post(
      "properties/$propertyId/favor/",
      null,
      token: user.token,
    );
  }

  @override
  Future<void> unfavorProperty(int propertyId) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    await delete(
      "properties/$propertyId/favor/",
      token: user.token,
    );
  }
}
