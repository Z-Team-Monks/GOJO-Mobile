import '../models/user_reg_model.dart';
import 'register_client_api.dart';

abstract class RegisterRepository {
  Future<void> registerUser({required UserRegistrationModel user});
  Future<void> sendOtp({required String phone});
  Future<void> verifyUser({required String phone, required String otpCode});
}

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterClientAPI registerClientAPI;

  RegisterRepositoryImpl(this.registerClientAPI);

  @override
  Future<void> registerUser({required UserRegistrationModel user}) async {
    await registerClientAPI.registerUser(user: user);
  }

  @override
  Future<void> sendOtp({required String phone}) async {
    await registerClientAPI.sendOtp(phone: phone);
  }

  @override
  Future<void> verifyUser({required String phone, required String otpCode}) async {
    await registerClientAPI.verifyUser(phone: phone, otpCode: otpCode);
  }
}

class RegisterRepositoryFake implements RegisterRepository {
  @override
  Future<void> registerUser({required UserRegistrationModel user}) async {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> sendOtp({required String phone}) async {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> verifyUser({required String phone, required String otpCode}) async {
    return Future.delayed(const Duration(seconds: 1));
  }
}
