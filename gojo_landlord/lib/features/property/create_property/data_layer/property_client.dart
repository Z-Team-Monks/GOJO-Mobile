import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

abstract class PropertyClientAPI {
  Future<Response> getCategories();
  Future<Response> getFacilities();
  Future<Response> postProperty(Map<String, dynamic> newPropertyJson);
}

class PropertyClientImpl extends BaseApiClient implements PropertyClientAPI {
  @override
  Future<Response> getCategories() {
    return get("/categories/");
  }

  @override
  Future<Response> getFacilities() {
    return get("/facilities/");
  }

  @override
  Future<Response> postProperty(Map<String, dynamic> newPropertyJson) {
    // TODO: Pass the users token here.
    debugPrint("Property Object: $newPropertyJson");
    return post("/properties/", newPropertyJson);
  }
}
