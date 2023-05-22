import 'package:dartz/dartz.dart';
import 'package:gojo/core/model/user.dart';
import 'package:gojo/features/auth/signin/data_layer/repository/sign_in_client.dart';

abstract class SignInRepositoryAPI {
  Future<Either<User, Error>> authenticate({
    required String phoneNumber,
    required String password,
  });

  Future<void> persistUser(User user);
}

class SignInRepositoryImpl {
  final SignInClientAPI signInClient;

  SignInRepositoryImpl(this.signInClient);

  Future<Either<User, Error>> authenticate({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await signInClient.authenticate(
        phoneNumber: phoneNumber,
        password: password,
      );
      return Left(User.fromJson(response.data));
    } catch (e) {
      return Right(e as Error);
    }
  }
}
