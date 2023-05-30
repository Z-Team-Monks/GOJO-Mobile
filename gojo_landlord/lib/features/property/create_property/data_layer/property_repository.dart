import 'package:flutter/material.dart';

import 'model/category.dart';
import 'model/facility.dart';
import 'model/new_property.dart';
import 'property_client.dart';

abstract class PropertyRepositoryAPI {
  Future<List<Category>> getCategories();
  Future<List<Facility>> getFacilities();
  Future<void> createProperty(NewProperty newProperty);
}

class PropertyRepositoryImpl implements PropertyRepositoryAPI {
  final PropertyClientAPI client;

  PropertyRepositoryImpl(this.client);

  @override
  Future<List<Category>> getCategories() async {
    final categoriesResponse = await client.getCategories();
    return List<Category>.from(
        categoriesResponse.data['results'].map((categoryJson) {
      return Category.fromJson(categoryJson);
    }).toList());
  }

  @override
  Future<List<Facility>> getFacilities() async {
    final facilitiesResponse = await client.getFacilities();
    return List<Facility>.from(
        facilitiesResponse.data['results'].map((facilityJson) {
      return Facility.fromJson(facilityJson);
    }).toList());
  }

  @override
  Future<void> createProperty(NewProperty newProperty) async {
    await client.postProperty(newProperty.toJson());
  }
}

class PropertyRepositoryFake implements PropertyRepositoryAPI {
  final _fakeCategories = [
    Category(id: 1, name: "Apartment"),
    Category(id: 2, name: "Condominium"),
    Category(id: 3, name: "House"),
    Category(id: 4, name: "Office"),
    Category(id: 5, name: "Store"),
    Category(id: 6, name: "Warehouse"),
  ];

  final _fakeFacilities = [
    Facility(id: 1, name: "Air Conditioning"),
    Facility(id: 2, name: "Balcony"),
    Facility(id: 3, name: "Cleaning Service"),
    Facility(id: 4, name: "Elevator"),
    Facility(id: 5, name: "Gym"),
    Facility(id: 6, name: "Internet"),
    Facility(id: 7, name: "Parking"),
    Facility(id: 8, name: "Pool"),
    Facility(id: 9, name: "Security"),
    Facility(id: 10, name: "Water"),
    Facility(id: 11, name: "Bed rooms"),
    Facility(id: 12, name: "Bath rooms"),
    Facility(id: 13, name: "Square area"),
  ];

  @override
  Future<List<Category>> getCategories() async {
    return Future.delayed(
        const Duration(milliseconds: 1), () => _fakeCategories);
  }

  @override
  Future<List<Facility>> getFacilities() {
    return Future.delayed(
        const Duration(milliseconds: 1), () => _fakeFacilities);
  }

  @override
  Future<void> createProperty(NewProperty newProperty) async {
    debugPrint("New property: ${newProperty.toJson()}");
  }
}
