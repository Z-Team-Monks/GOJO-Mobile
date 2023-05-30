import 'package:dio/dio.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/network/base_api_client.dart';

abstract class SignInClientAPI {
  Future<Response> authenticate({
    required String phoneNumber,
    required String password,
  });
}

class SignInClientImpl extends BaseApiClient implements SignInClientAPI {
  @override
  Future<Response> authenticate({
    required String phoneNumber,
    required String password,
  }) {
    return post("users/landlord_login/", {
      "username": phoneNumber,
      "password": password,
    });
  }
}
