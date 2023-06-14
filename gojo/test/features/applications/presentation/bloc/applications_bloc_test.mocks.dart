// Mocks generated by Mockito 5.4.0 from annotations
// in gojo/test/features/applications/presentation/bloc/applications_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:gojo/Gojo-Mobile-Shared/core/model/application.dart' as _i4;
import 'package:gojo/Gojo-Mobile-Shared/core/repository/application/application_repository.dart'
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

/// A class which mocks [ApplicationsRepositoryAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockApplicationsRepositoryAPI extends _i1.Mock
    implements _i2.ApplicationsRepositoryAPI {
  MockApplicationsRepositoryAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Application>> getPendingApplications({int? propertyId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPendingApplications,
          [],
          {#propertyId: propertyId},
        ),
        returnValue:
            _i3.Future<List<_i4.Application>>.value(<_i4.Application>[]),
      ) as _i3.Future<List<_i4.Application>>);
  @override
  _i3.Future<List<_i4.Application>> getApprovedApplications() =>
      (super.noSuchMethod(
        Invocation.method(
          #getApprovedApplications,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.Application>>.value(<_i4.Application>[]),
      ) as _i3.Future<List<_i4.Application>>);
  @override
  _i3.Future<List<_i4.Application>> getRejectedApplications() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRejectedApplications,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.Application>>.value(<_i4.Application>[]),
      ) as _i3.Future<List<_i4.Application>>);
  @override
  _i3.Future<void> withdrawPendingApplication(int? pendingApplicationId) =>
      (super.noSuchMethod(
        Invocation.method(
          #withdrawPendingApplication,
          [pendingApplicationId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> approvePendingApplication({
    required int? pendingApplicationId,
    required String? contractFilePath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #approvePendingApplication,
          [],
          {
            #pendingApplicationId: pendingApplicationId,
            #contractFilePath: contractFilePath,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
