import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../../../home/data_layer/model/property_item.dart';

abstract class ProfileClientAPI {
  Future<PropertyItemList> getRentedProperties();

  Future<PropertyItemList> getFavoriteProperties();
}

class ProfileClientImpl extends BaseApiClient implements ProfileClientAPI {
  @override
  Future<PropertyItemList> getRentedProperties() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final rentedPropertiesResponse = await get(
      'properties/rented/',
      token: user.token,
    );
    debugPrint(rentedPropertiesResponse.data.toString());
    return PropertyItemList.fromJson(
      rentedPropertiesResponse.data,
    );
  }

  @override
  Future<PropertyItemList> getFavoriteProperties() async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();

    if (user == null) {
      throw Exception("User's not logged in!");
    }

    final favoritePropertiesResponse = await get(
      'properties/favorites/',
      token: user.token,
    );
    return PropertyItemList.fromJson(
      favoritePropertiesResponse.data,
    );
  }
}
