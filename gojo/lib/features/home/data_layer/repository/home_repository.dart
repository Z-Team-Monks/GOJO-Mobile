import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../model/property_item.dart';
import 'home_client.dart';

/// An abstract class defining the interface for a home repository API.
abstract class HomeRepositoryAPI {
  /// Returns a `Future` that resolves to a list of home property items.
  Future<List<PropertyItem>> getPropertyItems();

  Future<List<String>> getCategories();

  Future<List<String>> getFacilities();
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
  Future<List<PropertyItem>> getPropertyItems() async {
    final propertyItems = await homeClient.getPropertyItems();
    return propertyItems.items;
  }

  @override
  Future<List<String>> getCategories() async {
    return await homeClient.getCategories();
  }

  @override
  Future<List<String>> getFacilities() async {
    return await homeClient.getFacilities();
  }
}

/// A Fake implementation of the [HomeRepositoryAPI] contract.
class HomeRepositoryFake implements HomeRepositoryAPI {
  @override
  Future<List<PropertyItem>> getPropertyItems() {
    final items = [
      PropertyItem(
        id: "1",
        title: "Villa, Kemah Tinggi",
        thumbnailUrl: Resources.gojoImages.sofa,
        category: "Villa",
        facilities: [
          Facility(name: "Kitchen", count: 1),
          Facility(name: "Bedroom", count: 2),
        ],
        rent: 14000,
      ),
      PropertyItem(
        id: "2",
        title: "Studio in 4kilo",
        thumbnailUrl: Resources.gojoImages.sofa,
        category: "Studio",
        facilities: [
          Facility(name: "Kitchen", count: 1),
          Facility(name: "Bedroom", count: 2),
        ],
        rent: 24000,
      ),
      PropertyItem(
        id: "3",
        title: "Condominium",
        thumbnailUrl: Resources.gojoImages.sofa,
        category: "Studio",
        facilities: [
          Facility(name: "Kitchen", count: 1),
          Facility(name: "Bedroom", count: 2),
        ],
        rent: 34000,
      ),
    ];

    return Future.delayed(
      const Duration(seconds: 2),
      () => items,
    );
  }

  @override
  Future<List<String>> getCategories() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => ["Apartment", "Studio", "Villa"],
    );
  }

  @override
  Future<List<String>> getFacilities() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => ["Swimming pool", "Gym"],
    );
  }
}
