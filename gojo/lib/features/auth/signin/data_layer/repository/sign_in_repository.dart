import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/core/model/user.dart';
import 'sign_in_client.dart';

abstract class SignInRepositoryAPI {
  Future<Either<User, Exception>> authenticate({
    required String phoneNumber,
    required String password,
  });

  Future<Either<void, Exception>> forgotPassword({
    required String phoneNumber,
    required String newPassword,
  });
}

class SignInRepositoryImpl implements SignInRepositoryAPI {
  final SignInClientAPI signInClient;

  SignInRepositoryImpl(this.signInClient);

  @override
  Future<Either<User, Exception>> authenticate({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await signInClient.authenticate(
        phoneNumber: phoneNumber,
        password: password,
      );

      final user = User.fromJson(response.data['user']);

      await signInClient.registerFirebaseToken(
        firebaseToken: (await FirebaseMessaging.instance.getToken())!,
        appToken: user.token!,
      );

      return Left(user);
    } catch (e) {
      if (e is DioError) {
        debugPrint("Dio error ${e.message}");
        if (e.response != null) {
          if (e.response!.statusCode == 400) {
            return Right(Exception("Invalid phone number or password!"));
          }
          if (e.response!.statusCode == 412) {
            return Right(Exception(
              "Account is yet to be verified! Please hang on!",
            ));
          }
        }
      }
      debugPrint("Other error ${e.toString()}");
      return Right(Exception("Can't connect at the moment. Try again later!"));
    }
  }

  @override
  Future<Either<void, Exception>> forgotPassword({
    required String phoneNumber,
    required String newPassword,
  }) async {
    try {
      final response = await signInClient.forgotPassword(
        phoneNumber: phoneNumber,
        newPassword: newPassword,
      );
      return const Left(null);
    } catch (e) {
      return Right(Exception("Can't connect at the moment. Try again later!"));
    }
  }
}
