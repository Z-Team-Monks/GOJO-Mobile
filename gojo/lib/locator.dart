import 'package:get_it/get_it.dart';
import 'package:gojo/features/home/data_layer/repository/home_repository.dart';

class Locator {
  static void setup() {
    GetIt.I
        .registerLazySingleton<HomeRepositoryAPI>(() => HomeRepositoryFake());
  }
}
