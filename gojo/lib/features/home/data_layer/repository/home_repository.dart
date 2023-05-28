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
      'searchTerm': searchTerm,
      'categories': filterInput.selectedCategories.join(','),
      'facilities': filterInput.selectedFacilities.join(','),
      'minPrice': filterInput.minimumPriceRange.toString(),
      'maxPrice': filterInput.maximumPriceRange.toString(),
      'location': filterInput.location,
      'rating': filterInput.selectedRating.join(','),
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
        title: "Villa, Kemah Tinggi",
        thumbnailUrl: Resources.gojoImages.sofaNetwork,
        category: "Villa",
        facilities: [
          Facility(name: "Kitchen", amount: 1),
          Facility(name: "Bed rooms", amount: 2),
        ],
        rent: "14000",
        rating: 4.97,
      ),
      PropertyItem(
        id: 1,
        title: "Villa, Kemah Tinggi",
        thumbnailUrl: Resources.gojoImages.sofaNetwork,
        category: "Villa",
        facilities: [
          Facility(name: "Kitchen", amount: 1),
          Facility(name: "Bedroom", amount: 2),
        ],
        rent: "14000",
        rating: 4.97,
      ),
      PropertyItem(
        id: 1,
        title: "Villa, Kemah Tinggi",
        thumbnailUrl: Resources.gojoImages.sofaNetwork,
        category: "Villa",
        facilities: [
          Facility(name: "Kitchen", amount: 1),
          Facility(name: "Bedroom", amount: 2),
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
        Facility(name: "Swimming pool"),
        Facility(name: "Gym"),
      ],
    );
  }
}
