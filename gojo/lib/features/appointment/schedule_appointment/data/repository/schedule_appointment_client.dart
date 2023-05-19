import 'package:gojo/features/appointment/schedule_appointment/data/model/appointment.dart';

import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

/// An abstract class defining the API contract for reviewing property
abstract class ScheduleAppointmentClientAPI {
  Future<void> scheduleAppointment(AppointmentModel appointment);
}

class ScheduleAppointmentClientImpl extends BaseApiClient
    implements ScheduleAppointmentClientAPI {
  @override
  Future<void> scheduleAppointment(AppointmentModel appointment) async {
    await post(
      '/properties/${appointment.propertyId}/schedule',
      appointment,
    );
  }
}
