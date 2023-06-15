import 'package:flutter/material.dart';

import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../presentation/bloc/property_filter/model/filter_input.dart';
import '../model/property_item.dart';
import 'home_client.dart';

/// An abstract class defining the interface for a home repository API.
abstract class HomeRepositoryAPI {
  /// Returns a `Future` that resolves to a list of home property items.
  Future<List<PropertyItem>> getPropertyItems(
    String searchTerm,
    FilterInput filterInput,
  );

  Future<List<Category>> getCategories();

  Future<List<Facility>> getFacilities();
}

/// An implementation of the `HomeRepositoryAPI` interface that uses a
/// `HomeClientAPI` to make HTTP requests.
class HomeRepositoryImpl implements HomeRepositoryAPI {
  /// The `HomeClientAPI` instance used to make HTTP requests.
  final HomeClientAPI homeClient;

  /// Creates a new instance of `HomeRepositoryImpl` with the provided
  /// `HomeClientAPI`.
  HomeRepositoryImpl(this.homeClient);

  /// Returns a `Future` that resolves to a list of home property items obtained
  /// from the `homeClient`.
  @override
  Future<List<PropertyItem>> getPropertyItems(
    String searchTerm,
    FilterInput filterInput,
  ) async {
    try {
      final getPropertiesUrl = _constructSearchFilterQueryParam(
        searchTerm,
        filterInput,
      );
      final propertyItems = await homeClient.getPropertyItems(getPropertiesUrl);
      return propertyItems.items;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    return await homeClient.getCategories();
  }

  @override
  Future<List<Facility>> getFacilities() async {
    return await homeClient.getFacilities();
  }

  String _constructSearchFilterQueryParam(
    String searchTerm,
    FilterInput filterInput,
  ) {
    final filterQueryParams = {
      'q': searchTerm,
      'categories': filterInput.selectedCategories.map((c) => c.id).join(','),
      'facilities': filterInput.selectedFacilities.map((f) => f.id).join(','),
      'minPrice': filterInput.minimumPriceRange.toString(),
      'maxPrice': filterInput.maximumPriceRange.toString(),
      'location': filterInput.location,
      'rating': filterInput.selectedRating,
    };

    final nonEmptyQueryParams = filterQueryParams.entries
        .where((entry) =>
            entry.value != null && entry.value != '' && entry.value!.isNotEmpty)
        .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value!)}')
        .toList();

    return nonEmptyQueryParams.join('&');
  }
}

// A Fake implementation of the [HomeRepositoryAPI] contract.
class HomeRepositoryFake implements HomeRepositoryAPI {
  @override
  Future<List<PropertyItem>> getPropertyItems(
    String searchTerm,
    FilterInput filterInput,
  ) {
    final items = [
      PropertyItem(
        id: 1,
        title: "Kemah Tinggi",
        thumbnailUrl: Resources.gojoImages.sofaNetwork,
        category: "Villa",
        facilities: [
          Facility(id: 1, name: "Kitchen", amount: 1),
          Facility(id: 2, name: "Bedroom", amount: 2),
          Facility(id: 3, name: "Square area", amount: 500),
        ],
        rent: "14000",
        rating: 4.97,
      ),
      PropertyItem(
        id: 1,
        title: "Great Housing",
        thumbnailUrl:
            "https://images.unsplash.com/photo-1615873968403-89e068629265?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2064&q=80",
        category: "Apartama",
        facilities: [
          Facility(id: 1, name: "Kitchen", amount: 1),
          Facility(id: 2, name: "Bedroom", amount: 2),
          Facility(id: 3, name: "Square area", amount: 350),
        ],
        rent: "14000",
        rating: 4.97,
      ),
      PropertyItem(
        id: 1,
        title: "Tiny home in 4 kilo",
        thumbnailUrl: Resources.gojoImages.sofaNetwork,
        category: "Condominium",
        facilities: [
          Facility(id: 1, name: "Kitchen", amount: 1),
          Facility(id: 2, name: "Bedroom", amount: 2),
        ],
        rent: "14000",
        rating: 4.97,
      ),
    ];

    return Future.delayed(
      const Duration(seconds: 2),
      () => items,
    );
  }

  @override
  Future<List<Category>> getCategories() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        Category(name: "Villa", id: 1),
        Category(name: "Apartment", id: 2),
        Category(name: "Studio", id: 3),
      ],
    );
  }

  @override
  Future<List<Facility>> getFacilities() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        Facility(id: 3, name: "Swimming pool"),
        Facility(id: 4, name: "Gym"),
      ],
    );
  }
}
