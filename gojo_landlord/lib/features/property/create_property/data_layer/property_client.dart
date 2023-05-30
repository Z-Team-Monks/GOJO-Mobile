import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

abstract class PropertyClientAPI {
  Future<Response> getCategories();
  Future<Response> getFacilities();
  Future<Response> postProperty(Map<String, dynamic> newPropertyJson);
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
    return post("properties/", newPropertyJson, token: user?.token);
  }
}
