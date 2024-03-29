// Mocks generated by Mockito 5.4.0 from annotations
// in gojo/test/features/profile/presentation/bloc/profile_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:gojo/features/home/data_layer/model/property_item.dart' as _i2;
import 'package:gojo/features/profile/data_layer/repository/profile_repository.dart'
    as _i3;
import 'package:gojo/Gojo-Mobile-Shared/core/model/user.dart' as _i6;
import 'package:gojo/Gojo-Mobile-Shared/core/repository/user_repository.dart'
    as _i5;
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

class _FakePropertyItemList_0 extends _i1.SmartFake
    implements _i2.PropertyItemList {
  _FakePropertyItemList_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProfileRepositoryAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileRepositoryAPI extends _i1.Mock
    implements _i3.ProfileRepositoryAPI {
  MockProfileRepositoryAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.PropertyItemList> getRentedProperties() => (super.noSuchMethod(
        Invocation.method(
          #getRentedProperties,
          [],
        ),
        returnValue:
            _i4.Future<_i2.PropertyItemList>.value(_FakePropertyItemList_0(
          this,
          Invocation.method(
            #getRentedProperties,
            [],
          ),
        )),
      ) as _i4.Future<_i2.PropertyItemList>);
  @override
  _i4.Future<_i2.PropertyItemList> getFavoriteProperties() =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoriteProperties,
          [],
        ),
        returnValue:
            _i4.Future<_i2.PropertyItemList>.value(_FakePropertyItemList_0(
          this,
          Invocation.method(
            #getFavoriteProperties,
            [],
          ),
        )),
      ) as _i4.Future<_i2.PropertyItemList>);
}

/// A class which mocks [UserRepositoryAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepositoryAPI extends _i1.Mock implements _i5.UserRepositoryAPI {
  MockUserRepositoryAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> persistUser(_i6.User? user) => (super.noSuchMethod(
        Invocation.method(
          #persistUser,
          [user],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<_i6.User?> getUser() => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [],
        ),
        returnValue: _i4.Future<_i6.User?>.value(),
      ) as _i4.Future<_i6.User?>);
  @override
  _i4.Future<void> deleteUser() => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
