import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';

abstract class FavoritePropertyClient {
  Future<void> favorProperty(String propertyId);
  Future<void> unfavorProperty(String propertyId);
}

class FavoritePropertyClientImpl extends BaseApiClient
    implements FavoritePropertyClient {
  @override
  Future<void> favorProperty(String propertyId) async {
    await post("/properties/$propertyId", null);
  }

  @override
  Future<void> unfavorProperty(String propertyId) async {
    await delete("/properties/$propertyId");
  }
}
