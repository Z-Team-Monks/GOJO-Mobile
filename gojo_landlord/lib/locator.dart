import 'package:get_it/get_it.dart';

import 'features/profile/data_layer/repository/profile_repository.dart';

class Locator {
  static void setup() {
    GetIt.I.registerLazySingleton<ProfileRepositoryAPI>(
      () => ProfileRepositoryFake(),
    );
  }
}
