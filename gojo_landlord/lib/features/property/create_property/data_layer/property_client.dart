import 'package:dio/dio.dart';

import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

abstract class PropertyClientAPI {
  Future<Response> getCategories();
  Future<Response> getFacilities();
}

class PropertyClientImpl extends BaseApiClient implements PropertyClientAPI {
  @override
  Future<Response> getCategories() {
    return get("/categories");
  }

  @override
  Future<Response> getFacilities() {
    return get("/facilities");
  }
}
