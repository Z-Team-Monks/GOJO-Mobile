import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/features/map/data/model/property_mapview_item.dart';

import 'map_view_client.dart';

abstract class MapViewRepository {
  Future<List<PropertyMapViewItem>> fetchPropertiesNearby(Location location);
}

class MapViewRepositoryImpl implements MapViewRepository {
  final MapViewClient mapViewClient;

  MapViewRepositoryImpl(this.mapViewClient);

  @override
  Future<List<PropertyMapViewItem>> fetchPropertiesNearby(
    Location location,
  ) async {
    return await mapViewClient.fetchPropertiesNearby(location);
  }
}

class MapViewRepositoryFake implements MapViewRepository {
  @override
  Future<List<PropertyMapViewItem>> fetchPropertiesNearby(Location location) {
    List<PropertyMapViewItem> properties = [
      PropertyMapViewItem(
        id: "1",
        title: "Niko’s Auditorium",
        price: "45,000",
        address: "Jl. Kartika Plaza, 38/1",
        image: Resources.gojoImages.sofa,
        rating: 4.7,
        location: Location(
          lat: location.lat + 0.001,
          lng: location.lng,
        ),
      ),
      PropertyMapViewItem(
        id: "2",
        title: "Villa, The Arsana Estate",
        price: "45,000",
        address: "Jl. Kartika Plaza, 38/1",
        image: Resources.gojoImages.sofa,
        rating: 4.7,
        location: Location(
          lat: location.lat,
          lng: location.lng + 0.001,
        ),
      ),
    ];

    return Future.delayed(
      const Duration(seconds: 1),
      () => properties,
    );
  }
}
