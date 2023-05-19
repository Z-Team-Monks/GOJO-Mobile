import 'package:gojo/features/appointment/schedule_appointment/data/model/appointment.dart';

/// An abstract class defining the interface for a schedule appointment repository API.
abstract class ScheduleAppointmentRepository {
  /// Returns a `Future` that resolves to a scheduled appointment.
  Future<AppointmentModel> scheduleAppointment(AppointmentModel appointment);
}

class ScheduleAppointmentRepositoryImpl
    implements ScheduleAppointmentRepository {
  final ScheduleAppointmentRepository scheduleAppointmentClient;

  ScheduleAppointmentRepositoryImpl(this.scheduleAppointmentClient);

  @override
  Future<AppointmentModel> scheduleAppointment(
      AppointmentModel appointment) async {
    return await scheduleAppointmentClient.scheduleAppointment(appointment);
  }
}

/// A Fake implementation of the [ScheduleAppointmentRepositoryAPI] contract.
class ScheduleAppointmentRepositoryFake
    implements ScheduleAppointmentRepository {
  @override
  Future<AppointmentModel> scheduleAppointment(AppointmentModel appointment) {
    appointment = AppointmentModel(
      date: "1",
      propertyId: "1",
      timeSlot: "2:00 AM",
    );

    return Future.delayed(
      const Duration(seconds: 1),
      () => appointment,
    );
  }
}
