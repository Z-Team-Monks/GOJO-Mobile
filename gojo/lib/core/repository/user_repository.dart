import 'package:gojo/Gojo-Mobile-Shared/local_storage/local_storage_api.dart';
import 'package:gojo/core/model/user.dart';

abstract class UserRepositoryAPI {
  Future<void> persistUser(User user);
  Future<User?> getUser();
  Future<void> deleteUser();
}

class UserRepositoryImpl implements UserRepositoryAPI {
  final userRepsitoryKey = "user";
  final LocalStorageAPI<User> localStorage;

  UserRepositoryImpl(this.localStorage);

  @override
  Future<void> persistUser(User user) async {
    await localStorage.write(userRepsitoryKey, user);
  }

  @override
  Future<User?> getUser() {
    return localStorage.read(userRepsitoryKey);
  }

  @override
  Future<void> deleteUser() async {
    await localStorage.delete(userRepsitoryKey);
  }
}
