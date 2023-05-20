import 'package:get_it/get_it.dart';
import 'package:gojo/features/applications/data_layer/repository/application_repository.dart';
import 'package:gojo/features/appointment/schedule_appointment/data/repository/schedule_appointment_repository.dart';
import 'package:gojo/features/map/data/repository/map_view_repository.dart';
import 'package:gojo/features/appointment/my_appointments/data_layer/repository/my_appointments_repository.dart';
import 'package:gojo/features/messages/chat/data/repository/chat_repository.dart';
import 'package:gojo/features/messages/chat/presentation/bloc/chat_gen.dart';
import 'package:gojo/features/messages/chat/presentation/bloc/chat_message_bloc.dart';

import 'features/home/data_layer/repository/home_repository.dart';
import 'features/profile/data_layer/repository/profile_repository.dart';
import 'features/transactions/data_layer/repository/transactions_repository.dart';

class Locator {
  static void setup() {
    GetIt.I.registerLazySingleton<HomeRepositoryAPI>(
      () => HomeRepositoryFake(),
    );

    GetIt.I.registerLazySingleton<ProfileRepositoryAPI>(
      () => ProfileRepositoryFake(),
    );

    GetIt.I.registerLazySingleton<TransactionsRepositoryAPI>(
      () => TransactionsRepositoryFake(),
    );

    GetIt.I.registerLazySingleton<ApplicationsRepositoryAPI>(
      () => ApplicationRepositoryFake(),
    );

    GetIt.I.registerLazySingleton<MyAppointmentsRepositoryAPI>(
      () => MyAppointmentsRepositoryFake(),
    );

    GetIt.I.registerLazySingleton(
      () => ChatMessageBloc(
        chatRepository: const ChatRepositoryFakeImpl(),
      ),
    );

    GetIt.I.registerLazySingleton(
      () => ChatGenerator(
        chatMessageBloc: GetIt.I<ChatMessageBloc>(),
      ),
    );

    GetIt.I.registerLazySingleton(
      () => ScheduleAppointmentRepositoryFake(),
    );

    GetIt.I.registerLazySingleton(
      () => MapViewRepositoryFake(),
    );
  }
}
