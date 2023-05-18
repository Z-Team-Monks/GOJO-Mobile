import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../../../home/data_layer/model/property_item.dart';

abstract class ProfileClientAPI {
  Future<PropertyItemList> getRentedProperties();

  Future<PropertyItemList> getFavoriteProperties();
}

class ProfileClientImpl extends BaseApiClient implements ProfileClientAPI {
  @override
  Future<PropertyItemList> getRentedProperties() async {
    final rentedPropertiesResponse = await get('/property/rented');
    return PropertyItemList.fromJson(rentedPropertiesResponse.data);
  }

  @override
  Future<PropertyItemList> getFavoriteProperties() async {
    final favoritePropertiesResponse = await get('/property/favorite');
    return PropertyItemList.fromJson(favoritePropertiesResponse.data);
  }
}
