import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Gojo-Mobile-Shared/core/model/user.dart';
import 'Gojo-Mobile-Shared/core/repository/application/application_cilent.dart';
import 'Gojo-Mobile-Shared/core/repository/application/application_repository.dart';
import 'Gojo-Mobile-Shared/core/repository/user_repository.dart';
import 'Gojo-Mobile-Shared/local_storage/local_storage_impl.dart';
import 'features/appointments/data_layer/repository/my_appointments_client.dart';
import 'features/appointments/data_layer/repository/my_appointments_repository.dart';
import 'features/auth/register/data/repository/register_client_api.dart';
import 'features/auth/register/data/repository/register_repository.dart';
import 'features/auth/signin/data_layer/repository/sign_in_client.dart';
import 'features/auth/signin/data_layer/repository/sign_in_repository.dart';
import 'features/home/data_layer/repository/home_client.dart';
import 'features/home/data_layer/repository/home_repository.dart';
import 'features/map/data/repository/map_view_repository.dart';
import 'features/messages/chat/presentation/bloc/chat_message_bloc.dart';
import 'features/messages/contacts/data/repository/contact_repository.dart';
import 'features/profile/data_layer/repository/profile_client.dart';
import 'features/profile/data_layer/repository/profile_repository.dart';
import 'features/property/detail/data/repository/detail_client_api.dart';
import 'features/property/detail/data/repository/detail_repository.dart';
import 'features/review/data/repository/review_client_api.dart';
import 'features/review/data/repository/review_repository.dart';
import 'features/transactions/data_layer/repository/transactions_client.dart';
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
      // () => HomeRepositoryImpl(HomeClientImpl()),
    );

    GetIt.I.registerLazySingleton<ProfileRepositoryAPI>(
      // () => ProfileRepositoryFake(),
      () => ProfileRepositoryImpl(ProfileClientImpl()),
    );

    GetIt.I.registerLazySingleton<TransactionsRepositoryAPI>(
      // () => TransactionsRepositoryFake(),
      () => TransactionsRepositoryImpl(TransactionsClientImpl()),
    );

    GetIt.I.registerLazySingleton<ApplicationsRepositoryAPI>(
      // () => ApplicationRepositoryFake(),
      () => ApplicationRepositoryImpl(ApplicationsClientImpl()),
    );

    GetIt.I.registerLazySingleton<MyAppointmentsRepositoryAPI>(
      // () => MyAppointmentsRepositoryFake(),
      () => MyAppointmentsRepositoryImpl(MyAppointmemtsClientImpl()),
    );

    GetIt.I.registerLazySingleton(
      () => ChatMessageBloc(),
    );

    GetIt.I.registerLazySingleton<PropertyDetailRepository>(
      // () => PropertyDetailRepositoryFake(),
      () => PropertyDetailRepositoryImpl(PropertyDetailClientImpl()),
    );

    GetIt.I.registerLazySingleton<MapViewRepository>(
      () => MapViewRepositoryFake(),
      // () => MapViewRepositoryImpl(MapViewClientImpl()),
    );

    GetIt.I.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryImpl(
        RegisterClientImpl(),
      ),
    );
    GetIt.I.registerLazySingleton<ContactRepository>(
      () => const ContactRepositoryFakeImpl(),
      // () => ContactRepositoryImpl(
      //   conctactClientAPI: ContactClientImpl(),
      // ),
    );

    GetIt.I.registerLazySingleton<ReviewRepositoryAPI>(
      // () => ReviewRepositoryFake(),
      () => ReviewRepositoryImpl(ReviewClientImpl()),
    );
  }

  static Future<Box> _getHiveBoxInstance() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UserAdapter());
    return await Hive.openBox('gojo');
  }
}
