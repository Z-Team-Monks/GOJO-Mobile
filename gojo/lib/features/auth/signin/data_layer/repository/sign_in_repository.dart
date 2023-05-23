import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gojo/core/model/user.dart';
import 'package:gojo/features/auth/signin/data_layer/repository/sign_in_client.dart';

abstract class SignInRepositoryAPI {
  Future<Either<User, Exception>> authenticate({
    required String phoneNumber,
    required String password,
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
      return Left(User.fromJson(response.data['user']));
    } catch (e) {
      if (e is DioError) {
        debugPrint("Dio error ${e.message}");
        if (e.response != null && e.response!.statusCode == 400) {
          return Right(Exception("Invalid phone number or password!"));
        }
      }
      debugPrint("Other error ${e.toString()}");
      return Right(Exception("Can't connect at the moment. Try again later!"));
    }
  }
}
