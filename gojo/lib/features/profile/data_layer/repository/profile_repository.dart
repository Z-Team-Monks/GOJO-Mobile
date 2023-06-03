import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../home/data_layer/model/property_item.dart';
import 'profile_client.dart';

abstract class ProfileRepositoryAPI {
  Future<PropertyItemList> getRentedProperties();

  Future<PropertyItemList> getFavoriteProperties();
}

class ProfileRepositoryImpl implements ProfileRepositoryAPI {
  final ProfileClientAPI profileClient;

  ProfileRepositoryImpl(this.profileClient);

  @override
  Future<PropertyItemList> getFavoriteProperties() {
    return profileClient.getFavoriteProperties();
  }

  @override
  Future<PropertyItemList> getRentedProperties() {
    return profileClient.getRentedProperties();
  }
}

class ProfileRepositoryFake implements ProfileRepositoryAPI {
  final PropertyItemList rentedPropertyItems;
  final PropertyItemList appliedPropertyItems;

  static final fakePropertyItems = PropertyItemList([
    PropertyItem(
      id: 1,
      title: "Villa, Kemah Tinggi",
      description: "Description goes here",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
      category: "Villa",
      facilities: [
        Facility(id: 1, name: "Kitchen", amount: 1),
        Facility(id: 2, name: "Bedroom", amount: 2),
      ],
      rent: "14000",
      rating: 4.9,
    ),
    PropertyItem(
      id: 2,
      title: "Studio in 4kilo",
      description: "Description goes here",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
      category: "Studio",
      facilities: [
        Facility(id: 1, name: "Kitchen", amount: 1),
        Facility(id: 2, name: "Bedroom", amount: 2),
      ],
      rent: "24000",
      rating: 4.9,
    ),
    PropertyItem(
      id: 3,
      title: "Condominium",
      description: "Description goes here",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
      category: "Studio",
      facilities: [
        Facility(id: 1, name: "Kitchen", amount: 1),
        Facility(id: 2, name: "Bedroom", amount: 2),
      ],
      rent: "34000",
      rating: 4.9,
    ),
  ]);

  ProfileRepositoryFake({
    PropertyItemList? rentedPropertyItems,
    PropertyItemList? appliedPropertyItems,
  })  : rentedPropertyItems = rentedPropertyItems ?? fakePropertyItems,
        appliedPropertyItems = appliedPropertyItems ?? fakePropertyItems;

  @override
  Future<PropertyItemList> getFavoriteProperties() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => rentedPropertyItems,
    );
  }

  @override
  Future<PropertyItemList> getRentedProperties() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => appliedPropertyItems,
    );
  }
}
