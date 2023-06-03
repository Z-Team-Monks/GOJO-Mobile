import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/property_item.dart';

/// An abstract class defining the API contract for retrieving home property
/// items.
abstract class HomeClientAPI {
  /// Retrieves a list of home property items from the API.
  ///
  /// This method sends an HTTP GET request to the API to retrieve a list of
  /// home property items. It returns a [PropertyItemList] object
  /// representing the list of items that were retrieved.
  Future<PropertyItemList> getPropertyItems(String queryUrl);

  /// Retrieves a list of categories.
  Future<List<Category>> getCategories();

  /// Retrieves a list of facilities.
  Future<List<Facility>> getFacilities();
}

/// An implementation of the [HomeClientAPI] contract.
class HomeClientImpl extends BaseApiClient implements HomeClientAPI {
  @override
  Future<PropertyItemList> getPropertyItems(String queryUrl) async {
    String getPropertiesUrl = 'properties/';
    if (queryUrl.isNotEmpty) {
      getPropertiesUrl += '?$queryUrl';
    }
    final homePropertiesResponse = await get(getPropertiesUrl);
    return PropertyItemList.fromJson(homePropertiesResponse.data);
  }

  @override
  Future<List<Category>> getCategories() async {
    final categoriesResponse = await get('properties/categories/');
    final List<dynamic> categoryJsonList = categoriesResponse.data['results'];

    return categoryJsonList.map((categoryJson) {
      return Category.fromJson(categoryJson);
    }).toList();
  }

  @override
  Future<List<Facility>> getFacilities() async {
    final facilitiesResponse = await get('properties/facilities/');
    final List<dynamic> facilityJsonList = facilitiesResponse.data['results'];

    return facilityJsonList.map((facilityJson) {
      return Facility.fromJson(facilityJson);
    }).toList();
  }
}
