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
      id: "1",
      title: "Villa, Kemah Tinggi",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
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
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
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
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
      category: "Studio",
      facilities: [
        Facility(name: "Kitchen", count: 1),
        Facility(name: "Bedroom", count: 2),
      ],
      rent: 34000,
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
