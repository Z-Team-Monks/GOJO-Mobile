import 'package:gojo_landlord/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo_landlord/features/profile/data_layer/model/property_item.dart';
import 'package:gojo_landlord/features/profile/data_layer/repository/profile_client.dart';

abstract class ProfileRepositoryAPI {
  Future<PropertyItemList> getPostedProperties();

  Future<PropertyItemList> getInReviewProperties();
}

class ProfileRepositoryImpl implements ProfileRepositoryAPI {
  final ProfileClientAPI profileClient;

  ProfileRepositoryImpl(this.profileClient);

  @override
  Future<PropertyItemList> getPostedProperties() {
    return profileClient.getPostedProperties();
  }

  @override
  Future<PropertyItemList> getInReviewProperties() {
    return profileClient.getInReviewProperties();
  }
}

class ProfileRepositoryFake implements ProfileRepositoryAPI {
  final PropertyItemList postedPropertyItems;
  final PropertyItemList inreviewPropertyItems;

  static final fakePropertyItems = PropertyItemList([
    PropertyItem(
      id: "1",
      title: "Villa, Kemah Tinggi",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
    ),
    PropertyItem(
      id: "2",
      title: "Studio in 4kilo",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
    ),
    PropertyItem(
      id: "3",
      title: "Condominium",
      thumbnailUrl: Resources.gojoImages.sofaNetwork,
    ),
  ]);

  ProfileRepositoryFake({
    PropertyItemList? postedPropertyItems,
    PropertyItemList? inreviewPropertyItems,
  })  : postedPropertyItems = postedPropertyItems ?? fakePropertyItems,
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
}
