import 'package:flutter/material.dart';
import 'package:gojo/features/map/data/model/property_mapview_item.dart';

import '../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

/// An abstract class defining the API contract for getting nearby properties
abstract class MapViewClient {
  Future<List<PropertyMapViewItem>> fetchPropertiesNearby(Location location);
}

class MapViewClientImpl extends BaseApiClient implements MapViewClient {
  @override
  Future<List<PropertyMapViewItem>> fetchPropertiesNearby(
      Location location) async {
    final response = await get(
      'properties/',
    );

    debugPrint(response.data.toString());

    return List<PropertyMapViewItem>.from(
      (response.data['results'] as List).map(
        (model) => PropertyMapViewItem.fromJson(model),
      ),
    );
  }
}
