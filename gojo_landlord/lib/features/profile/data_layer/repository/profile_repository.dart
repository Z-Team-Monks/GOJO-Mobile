import '../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../model/property_item.dart';
import 'profile_client.dart';

abstract class ProfileRepositoryAPI {
  Future<PropertyItemList> getPostedProperties();

  Future<PropertyItemList> getRentedProperties();

  Future<PropertyItemList> getInReviewProperties();

  Future<void> endContract(int propertyId);
}

class ProfileRepositoryImpl implements ProfileRepositoryAPI {
  final ProfileClientAPI profileClient;

  ProfileRepositoryImpl(this.profileClient);

  @override
  Future<PropertyItemList> getPostedProperties() {
    return profileClient.getPostedProperties();
  }

  @override
  Future<PropertyItemList> getRentedProperties() {
    return profileClient.getRentedProperties();
  }

  @override
  Future<PropertyItemList> getInReviewProperties() {
    return profileClient.getInReviewProperties();
  }

  @override
  Future<void> endContract(int propertyId) {
    return profileClient.endContract(propertyId);
  }
}

class ProfileRepositoryFake implements ProfileRepositoryAPI {
  final PropertyItemList postedPropertyItems;
  final PropertyItemList rentedPropertyItems;
  final PropertyItemList inreviewPropertyItems;

  static final fakePropertyItems = PropertyItemList([
    PropertyItem(
      id: 1,
      title: "Kemah Tinggi",
      description: "Kemah Tinggi",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
      category: "Villa",
    ),
    PropertyItem(
      id: 1,
      title: "Kemah Tinggi",
      description: "Kemah Tinggi",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
      category: "Villa",
    ),
    PropertyItem(
      id: 1,
      title: "Kemah Tinggi",
      description: "Kemah Tinggi",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
      category: "Villa",
    ),
  ]);

  ProfileRepositoryFake({
    PropertyItemList? postedPropertyItems,
    PropertyItemList? inreviewPropertyItems,
  })  : postedPropertyItems = postedPropertyItems ?? fakePropertyItems,
        rentedPropertyItems = postedPropertyItems ?? fakePropertyItems,
        inreviewPropertyItems = inreviewPropertyItems ?? fakePropertyItems;

  @override
  Future<PropertyItemList> getPostedProperties() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => postedPropertyItems,
    );
  }

  @override
  Future<PropertyItemList> getInReviewProperties() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => inreviewPropertyItems,
    );
  }

  @override
  Future<PropertyItemList> getRentedProperties() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => rentedPropertyItems,
    );
  }

  @override
  Future<void> endContract(int propertyId) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => null,
    );
  }
}
