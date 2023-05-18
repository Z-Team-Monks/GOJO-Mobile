import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/property_item.dart';

abstract class ProfileClientAPI {
  Future<PropertyItemList> getPostedProperties();

  Future<PropertyItemList> getInReviewProperties();
}

class ProfileClientImpl extends BaseApiClient implements ProfileClientAPI {
  @override
  Future<PropertyItemList> getPostedProperties() async {
    final postedPropertiesResponse = await get('/property/posted');
    return PropertyItemList.fromJson(postedPropertiesResponse.data);
  }

  @override
  Future<PropertyItemList> getInReviewProperties() async {
    final inReviewPropertiesResponse = await get('/property/inreview');
    return PropertyItemList.fromJson(inReviewPropertiesResponse.data);
  }
}
