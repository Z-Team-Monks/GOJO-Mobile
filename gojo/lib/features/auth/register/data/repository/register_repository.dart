import 'package:gojo/features/auth/register/data/repository/register_client_api.dart';

import '../../../../../core/model/user.dart';

abstract class RegisterRepository {
  Future<void> registerUser({required User user, String? filePath});
}

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterClientAPI registerClientAPI;

  RegisterRepositoryImpl(this.registerClientAPI);

  @override
  Future<void> registerUser({required User user, String? filePath}) async {
    await registerClientAPI.registerUser(user: user, filePath: filePath);
  }
}

class RegisterRepositoryFake implements RegisterRepository {
  @override
  Future<void> registerUser({required User user, String? filePath}) async {
    return Future.delayed(const Duration(seconds: 1));
  }
}
