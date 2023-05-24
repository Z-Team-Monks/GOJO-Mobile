import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/apply_for_rent_model.dart';
import '../model/appointment.dart';
import '../model/property.dart';

abstract class PropertyDetailClientAPI {
  Future<Property> fetchProperty(String propertyId);
  Future<void> scheduleAppointment(AppointmentModel appointment);
  Future<void> applyForRent(ApplyForRentModel applyForRentModel);
  Future<void> favorProperty(String propertyId);
  Future<void> unfavorProperty(String propertyId);
}

class PropertyDetailClientImpl extends BaseApiClient
    implements PropertyDetailClientAPI {
  @override
  Future<Property> fetchProperty(String propertyId) async {
    final fetchPropertyResponse = await get(
      '/properties/$propertyId',
    );
    return Property.fromJson(fetchPropertyResponse.data);
  }

  @override
  Future<void> scheduleAppointment(AppointmentModel appointment) async {
    await post(
      '/properties/${appointment.propertyId}/schedule',
      appointment,
    );
  }

  @override
  Future<void> applyForRent(ApplyForRentModel applyForRentModel) async {
    await post(
      "/properties/${applyForRentModel.propertyId}/apply",
      applyForRentModel.toJson(),
    );
  }

  @override
  Future<void> favorProperty(String propertyId) async {
    await post("/properties/$propertyId/", null);
  }

  @override
  Future<void> unfavorProperty(String propertyId) async {
    await delete("/properties/$propertyId");
  }
}
