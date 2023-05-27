import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/features/property/create_property/data_layer/property_repository.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Gojo-Mobile-Shared/core/model/user.dart';
import 'Gojo-Mobile-Shared/core/repository/user_repository.dart';
import 'Gojo-Mobile-Shared/local_storage/local_storage_impl.dart';
import 'features/auth/signin/data_layer/repository/sign_in_client.dart';
import 'features/auth/signin/data_layer/repository/sign_in_repository.dart';
import 'features/profile/data_layer/repository/profile_repository.dart';

class Locator {
  static setup() async {
    // Initialize hive for local storage.
    final box = await _getHiveBoxInstance();

    GetIt.I.registerLazySingleton<UserRepositoryAPI>(
      () => UserRepositoryImpl(LocalStorageImpl(box)),
    );
    GetIt.I.registerLazySingleton<SignInRepositoryAPI>(
      () => SignInRepositoryImpl(SignInClientImpl()),
    );
    GetIt.I.registerLazySingleton<ProfileRepositoryAPI>(
      () => ProfileRepositoryFake(),
    );
    GetIt.I.registerLazySingleton<PropertyRepositoryAPI>(
      () => PropertyRepositoryFake(),
    );
  }

  static Future<Box> _getHiveBoxInstance() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UserAdapter());
    return await Hive.openBox('gojo');
  }
}
