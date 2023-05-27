import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/property_repository.dart';

import 'features/profile/data_layer/repository/profile_repository.dart';

class Locator {
  static void setup() {
    GetIt.I.registerLazySingleton<ProfileRepositoryAPI>(
      () => ProfileRepositoryFake(),
    );
    GetIt.I.registerLazySingleton<PropertyRepositoryAPI>(
      () => PropertyRepositoryFake(),
    );
  }
}
