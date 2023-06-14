part of 'map_view_bloc.dart';

abstract class MapViewEvent extends Equatable {}

class MapViewLoad extends MapViewEvent {
  @override
  List<Object?> get props => [];
}

class MapViewCenterChanged extends MapViewEvent {
  final Location center;

  MapViewCenterChanged({required this.center});

  @override
  List<Object?> get props => [center];
}

class MapViewPropertySelected extends MapViewEvent {
  final PropertyMapViewItem property;

  MapViewPropertySelected({required this.property});

  @override
  List<Object?> get props => [property];
}
