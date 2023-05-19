import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/model/property_mapview_item.dart';
import '../../data/repository/map_view_repository.dart';

part 'map_view_event.dart';
part 'map_view_state.dart';

class MapViewBloc extends Bloc<MapViewEvent, MapViewState> {
  final MapViewRepository mapViewRepository;

  MapViewBloc(this.mapViewRepository) : super(MapViewState()) {
    on<MapViewPropertySelected>((event, emit) {
      emit(state.copyWith(
        selectedProperty: event.property,
      ));
    });

    on<MapViewLoad>((event, emit) async {
      emit(state.copyWith(
        status: MapViewStatus.loading,
      ));

      final currentLocation = await _getCurrentLocation();
      if (currentLocation != null) {
        emit(state.copyWith(
          center: Location(
            lat: currentLocation.latitude,
            lng: currentLocation.longitude,
          ),
        ));
      }

      try {
        final properties = await mapViewRepository.fetchPropertiesNearby(
          state.center,
        );

        emit(state.copyWith(
          properties: properties,
          status: MapViewStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: MapViewStatus.error,
        ));
      }
    });
  }

  Future<Position?> _getCurrentLocation() async {
    bool hasPermission = await _handleLocationPermission();
    if (hasPermission) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }

    return null;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
}
