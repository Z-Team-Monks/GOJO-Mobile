import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/property.dart';

/// An abstract class defining the API contract for reviewing property
abstract class PropertyDetailClientAPI {
  Future<Property> fetchProperty(String propertyId);
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
}
