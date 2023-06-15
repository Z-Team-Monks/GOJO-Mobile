import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

abstract class PropertyClientAPI {
  Future<Response> getCategories();
  Future<Response> getFacilities();
  Future<Response> postProperty(Map<String, dynamic> newPropertyJson);
  Future<Response> updateProperty(
    int propertyId,
    Map<String, dynamic> updatedPropertyJson,
  );
}

class PropertyClientImpl extends BaseApiClient implements PropertyClientAPI {
  @override
  Future<Response> getCategories() {
    return get("properties/categories/");
  }

  @override
  Future<Response> getFacilities() {
    return get("properties/facilities/");
  }

  @override
  Future<Response> postProperty(Map<String, dynamic> newPropertyJson) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();
    debugPrint(newPropertyJson.toString());
    return post("properties/", newPropertyJson, token: user?.token);
  }

  @override
  Future<Response> updateProperty(
    int propertyId,
    Map<String, dynamic> updatedPropertyJson,
  ) async {
    final user = await GetIt.I<UserRepositoryAPI>().getUser();
    debugPrint(updatedPropertyJson.toString());
    return post(
      "properties/$propertyId/updateProperty/",
      updatedPropertyJson,
      token: user?.token,
    );
  }
}
