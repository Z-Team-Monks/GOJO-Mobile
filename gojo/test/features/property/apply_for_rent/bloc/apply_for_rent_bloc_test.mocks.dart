// Mocks generated by Mockito 5.4.0 from annotations
// in gojo/test/features/property/apply_for_rent/bloc/apply_for_rent_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:gojo/features/property/detail/data/model/apply_for_rent_model.dart'
    as _i6;
import 'package:gojo/features/property/detail/data/model/appointment.dart'
    as _i5;
import 'package:gojo/features/property/detail/data/model/property.dart' as _i2;
import 'package:gojo/features/property/detail/data/repository/detail_repository.dart'
    as _i3;
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

class _FakeProperty_0 extends _i1.SmartFake implements _i2.Property {
  _FakeProperty_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PropertyDetailRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPropertyDetailRepository extends _i1.Mock
    implements _i3.PropertyDetailRepository {
  MockPropertyDetailRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Property> fetchProperty(int? propertyId) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchProperty,
          [propertyId],
        ),
        returnValue: _i4.Future<_i2.Property>.value(_FakeProperty_0(
          this,
          Invocation.method(
            #fetchProperty,
            [propertyId],
          ),
        )),
      ) as _i4.Future<_i2.Property>);
  @override
  _i4.Future<void> scheduleAppointment(_i5.AppointmentModel? appointment) =>
      (super.noSuchMethod(
        Invocation.method(
          #scheduleAppointment,
          [appointment],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> applyForRent(_i6.ApplyForRentModel? applyForRentModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #applyForRent,
          [applyForRentModel],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> favorProperty(int? propertyId) => (super.noSuchMethod(
        Invocation.method(
          #favorProperty,
          [propertyId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
