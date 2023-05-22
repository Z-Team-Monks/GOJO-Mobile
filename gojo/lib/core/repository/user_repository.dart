import 'package:gojo/Gojo-Mobile-Shared/local_storage/local_storage_api.dart';
import 'package:gojo/core/model/user.dart';

abstract class UserRepositoryAPI {
  Future<void> persistUser(User user);
}

class UserRepositoryImpl implements UserRepositoryAPI {
  final LocalStorageAPI<User> localStorage;

  UserRepositoryImpl(this.localStorage);

  @override
  Future<void> persistUser(User user) async {
    await localStorage.write("user", user);
  }
}
