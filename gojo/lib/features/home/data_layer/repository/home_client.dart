import 'dart:convert';

import 'package:gojo/Gojo-Mobile-Shared/network/base_api_client.dart';
import 'package:gojo/features/home/data_layer/model/property_item.dart';

/// An abstract class defining the API contract for retrieving home property
/// items.
abstract class HomeClientAPI {
  /// Retrieves a list of home property items from the API.
  ///
  /// This method sends an HTTP GET request to the API to retrieve a list of
  /// home property items. It returns a [PropertyItemList] object
  /// representing the list of items that were retrieved.
  Future<PropertyItemList> getPropertyItems();

  /// Retrieves a list of strings representing available type of categories.
  Future<List<String>> getCategories();

  /// Retrieves a list of strings representing available type of facilities.
  Future<List<String>> getFacilities();
}

/// An implementation of the [HomeClientAPI] contract.
class HomeClientImpl extends BaseApiClient implements HomeClientAPI {
  @override
  Future<PropertyItemList> getPropertyItems() async {
    final homePropertiesResponse = await get('/properties');
    return PropertyItemList.fromJson(homePropertiesResponse.data);
  }

  @override
  Future<List<String>> getCategories() async {
    final categoriesResponse = await get('/categories');
    return jsonDecode(categoriesResponse.data).cast<String>();
  }

  @override
  Future<List<String>> getFacilities() async {
    final facilitiesResponse = await get('/facilities');
    return jsonDecode(facilitiesResponse.data).cast<String>();
  }
}
