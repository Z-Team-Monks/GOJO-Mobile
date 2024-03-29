// Mocks generated by Mockito 5.4.0 from annotations
// in gojo/test/features/appointments/presentation/bloc/appointments_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:gojo/features/appointments/data_layer/model/appointment.dart'
    as _i4;
import 'package:gojo/features/appointments/data_layer/repository/my_appointments_repository.dart'
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

/// A class which mocks [MyAppointmentsRepositoryAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockMyAppointmentsRepositoryAPI extends _i1.Mock
    implements _i2.MyAppointmentsRepositoryAPI {
  MockMyAppointmentsRepositoryAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Appointment>> getMyAppointments() => (super.noSuchMethod(
        Invocation.method(
          #getMyAppointments,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.Appointment>>.value(<_i4.Appointment>[]),
      ) as _i3.Future<List<_i4.Appointment>>);
  @override
  _i3.Future<void> cancelAppointment(int? id) => (super.noSuchMethod(
        Invocation.method(
          #cancelAppointment,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
