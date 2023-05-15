import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../../../home/data_layer/model/property_item.dart';

abstract class ProfileClientAPI {
  Future<PropertyItemList> getRentedProperties();

  Future<PropertyItemList> getfavoriteProperties();
}

class ProfileClientImpl extends BaseApiClient implements ProfileClientAPI {
  @override
  Future<PropertyItemList> getRentedProperties() async {
    final rentedPropertiesResponse = await get('/property/rented');
    return PropertyItemList.fromJson(rentedPropertiesResponse.data);
  }

  @override
  Future<PropertyItemList> getfavoriteProperties() async {
    final favoritePropertiesResponse = await get('/property/applied');
    return PropertyItemList.fromJson(favoritePropertiesResponse.data);
  }
}
