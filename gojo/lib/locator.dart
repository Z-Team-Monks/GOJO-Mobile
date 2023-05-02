import 'package:get_it/get_it.dart';
import 'package:gojo/features/home/data_layer/repository/home_repository.dart';
import 'package:gojo/features/profile/data_layer/repository/profile_repository.dart';

class Locator {
  static void setup() {
    GetIt.I.registerLazySingleton<HomeRepositoryAPI>(
      () => HomeRepositoryFake(),
    );

    GetIt.I.registerLazySingleton<ProfileRepositoryAPI>(
      () => ProfileRepositoryFake(),
    );
  }
}
