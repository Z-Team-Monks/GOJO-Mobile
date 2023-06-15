// Mocks generated by Mockito 5.4.0 from annotations
// in gojo/test/features/auth/register/presentation/bloc/register_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:gojo/features/auth/register/data/models/user_reg_model.dart'
    as _i4;
import 'package:gojo/features/auth/register/data/repository/register_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [RegisterRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegisterRepository extends _i1.Mock
    implements _i2.RegisterRepository {
  MockRegisterRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> registerUser({required _i4.UserRegistrationModel? user}) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerUser,
          [],
          {#user: user},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> sendOtp({required String? phone}) => (super.noSuchMethod(
        Invocation.method(
          #sendOtp,
          [],
          {#phone: phone},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> verifyUser({
    required String? phone,
    required String? otpCode,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #verifyUser,
          [],
          {
            #phone: phone,
            #otpCode: otpCode,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
