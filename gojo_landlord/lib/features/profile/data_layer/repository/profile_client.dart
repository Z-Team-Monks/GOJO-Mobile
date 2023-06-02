import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/property_item.dart';

abstract class ProfileClientAPI {
  Future<PropertyItemList> getPostedProperties();

  Future<PropertyItemList> getRentedProperties();

  Future<PropertyItemList> getInReviewProperties();
}

class ProfileClientImpl extends BaseApiClient implements ProfileClientAPI {
  @override
  Future<PropertyItemList> getPostedProperties() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();
    final postedPropertiesResponse =
        await get('properties/?type=posted', token: user?.token);
    return PropertyItemList.fromJson(postedPropertiesResponse.data);
  }

  @override
  Future<PropertyItemList> getRentedProperties() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();
    final rentedPropertiesResponse =
        await get('properties/?type=rented', token: user?.token);
    return PropertyItemList.fromJson(rentedPropertiesResponse.data);
  }

  @override
  Future<PropertyItemList> getInReviewProperties() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();
    final inReviewPropertiesResponse =
        await get('properties/?type=in_review', token: user?.token);
    return PropertyItemList.fromJson(inReviewPropertiesResponse.data);
  }
}
