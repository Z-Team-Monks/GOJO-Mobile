import 'package:dio/dio.dart';

import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../../../../../core/model/user.dart';

abstract class RegisterClientAPI {
  Future<void> registerUser({required User user, String? filePath});
}

class RegisterClientImpl extends BaseApiClient implements RegisterClientAPI {
  @override
  Future<void> registerUser({required User user, String? filePath}) async {
    FormData formData = FormData.fromMap({
      'file': filePath != null ? await MultipartFile.fromFile(filePath) : null,
      'json': user.toJson(),
    });
    await post('/users/', formData);
  }
}
