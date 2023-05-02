import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import 'package:gojo/features/home/data_layer/model/property_item.dart';

abstract class ProfileClientAPI {
  Future<PropertyItemList> getRentedProperties();

  Future<PropertyItemList> getAppliedProperties();
}

class ProfileClientImpl extends BaseApiClient implements ProfileClientAPI {
  @override
  Future<PropertyItemList> getRentedProperties() async {
    final rentedPropertiesResponse = await get('/property/rented');
    return PropertyItemList.fromJson(rentedPropertiesResponse.data);
  }

  @override
  Future<PropertyItemList> getAppliedProperties() async {
    final appliedPropertiesResponse = await get('/property/applied');
    return PropertyItemList.fromJson(appliedPropertiesResponse.data);
  }
}
