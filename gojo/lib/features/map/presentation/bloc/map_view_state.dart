part of 'map_view_bloc.dart';

enum MapViewStatus { loading, success, error }

class MapViewState {
  final List<PropertyMapViewItem> properties;
  final PropertyMapViewItem? selectedProperty;
  final Location center;
  final MapViewStatus status;

  MapViewState({
    this.properties = const [],
    this.selectedProperty,
    this.status = MapViewStatus.loading,
    this.center = const Location(lat: 8.9806, lng: 38.7578),
  });

  MapViewState copyWith({
    List<PropertyMapViewItem>? properties,
    PropertyMapViewItem? selectedProperty,
    MapViewStatus? status,
    Location? center,
  }) {
    return MapViewState(
      properties: properties ?? this.properties,
      selectedProperty: selectedProperty ?? this.selectedProperty,
      status: status ?? this.status,
      center: center ?? this.center,
    );
  }
}
