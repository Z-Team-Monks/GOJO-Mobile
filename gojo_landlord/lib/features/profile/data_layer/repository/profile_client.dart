import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/core/model/user.dart';
import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/property_item.dart';

abstract class ProfileClientAPI {
  Future<PropertyItemList> getPostedProperties();

  Future<PropertyItemList> getRentedProperties();

  Future<PropertyItemList> getInReviewProperties();

  Future<void> endContract(int propertyId);
}

class ProfileClientImpl extends BaseApiClient implements ProfileClientAPI {
  UserRepositoryAPI get userRepository => GetIt.I<UserRepositoryAPI>();

  Future<User?> _getUser() async {
    return userRepository.getUser();
  }

  Future<Map<String, dynamic>> _makeRequest(String path) async {
    final user = await _getUser();
    final response = await get(path, token: user?.token);
    return response.data;
  }

  @override
  Future<PropertyItemList> getPostedProperties() async {
    final postedPropertiesResponse =
        await _makeRequest('properties/?type=posted');
    return PropertyItemList.fromJson(postedPropertiesResponse);
  }

  @override
  Future<PropertyItemList> getRentedProperties() async {
    final rentedPropertiesResponse =
        await _makeRequest('properties/?type=rented');
    return PropertyItemList.fromJson(rentedPropertiesResponse);
  }

  @override
  Future<PropertyItemList> getInReviewProperties() async {
    final inReviewPropertiesResponse =
        await _makeRequest('properties/?type=in_review');
    return PropertyItemList.fromJson(inReviewPropertiesResponse);
  }

  @override
  Future<void> endContract(int propertyId) async {
    final user = await _getUser();
    await post(
      'properties/$propertyId/end_contract/',
      null,
      token: user?.token,
    );
  }
}
