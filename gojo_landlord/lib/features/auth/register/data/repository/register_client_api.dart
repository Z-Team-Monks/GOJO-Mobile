import 'package:dio/dio.dart';

import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../models/user_reg_model.dart';

abstract class RegisterClientAPI {
  Future<void> registerUser({required UserRegistrationModel user});
  Future<void> sendOtp({required String phone});
  Future<void> verifyUser({required String phone, required String otpCode});
}

class RegisterClientImpl extends BaseApiClient implements RegisterClientAPI {
  @override
  Future<void> registerUser({required UserRegistrationModel user}) async {
    FormData formData = FormData.fromMap({
      'identification': await MultipartFile.fromFile(user.identification),
      'avatar': user.profilePicture != null
          ? await MultipartFile.fromFile(user.profilePicture!)
          : null,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "phone": user.phoneNumber,
      "password": user.password,
    });
    await post('users/landlord/', formData);
  }

  @override
  Future<void> sendOtp({required String phone}) async {
    await post('users/resend_otp/', {"phone": phone});
  }

  @override
  Future<void> verifyUser({
    required String phone,
    required String otpCode,
  }) async {
    await post('users/verify_otp/', {"phone": phone, "code": otpCode});
  }
}
