import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Gojo-Mobile-Shared/local_storage/local_storage_impl.dart';
import 'core/model/user.dart';
import 'core/repository/user_repository.dart';
import 'features/applications/data_layer/repository/application_repository.dart';
import 'features/appointments/data_layer/repository/my_appointments_repository.dart';
import 'features/auth/register/data/repository/register_client_api.dart';
import 'features/auth/register/data/repository/register_repository.dart';
import 'features/auth/signin/data_layer/repository/sign_in_client.dart';
import 'features/auth/signin/data_layer/repository/sign_in_repository.dart';
import 'features/home/data_layer/repository/home_repository.dart';
import 'features/map/data/repository/map_view_repository.dart';
import 'features/messages/chat/presentation/bloc/chat_gen.dart';
import 'features/messages/chat/presentation/bloc/chat_message_bloc.dart';
import 'features/messages/contacts/data/repository/contact_repository.dart';
import 'features/profile/data_layer/repository/profile_repository.dart';
import 'features/property/detail/data/repository/detail_repository.dart';
import 'features/transactions/data_layer/repository/transactions_repository.dart';

class Locator {
  static setup() async {
    // Initialize hive for local storage.
    final box = await _getHiveBoxInstance();

    GetIt.I.registerLazySingleton<SignInRepositoryAPI>(
      () => SignInRepositoryImpl(SignInClientImpl()),
    );

    GetIt.I.registerLazySingleton<UserRepositoryAPI>(
      () => UserRepositoryImpl(LocalStorageImpl(box)),
    );

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
      () => ChatMessageBloc(),
    );

    GetIt.I.registerLazySingleton(
      () => ChatGenerator(
        chatMessageBloc: GetIt.I<ChatMessageBloc>(),
      ),
    );

    GetIt.I.registerLazySingleton(
      () => MyAppointmentsRepositoryFake(),
    );

    GetIt.I.registerLazySingleton(
      () => PropertyDetailRepositoryFake(),
    );

    GetIt.I.registerLazySingleton(
      () => MapViewRepositoryFake(),
    );

    GetIt.I.registerLazySingleton(
      () => ContactRepositoryFakeImpl(),
    );

    GetIt.I.registerLazySingleton(
      () => RegisterRepositoryImpl(
        RegisterClientImpl(),
      ),
    );
    // GetIt.I.registerLazySingleton(
    //   () => ContactRepositoryImpl(
    //     conctactClientAPI: ContactClientImpl(),
    //   ),
    // );
  }

  static Future<Box> _getHiveBoxInstance() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UserAdapter());
    return await Hive.openBox('gojo');
  }
}
