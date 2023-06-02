import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Gojo-Mobile-Shared/core/model/user.dart';
import 'Gojo-Mobile-Shared/core/repository/application/application_repository.dart';
import 'Gojo-Mobile-Shared/core/repository/user_repository.dart';
import 'Gojo-Mobile-Shared/local_storage/local_storage_impl.dart';
import 'features/auth/signin/data_layer/repository/sign_in_client.dart';
import 'features/auth/signin/data_layer/repository/sign_in_repository.dart';
import 'features/messages/chat/presentation/bloc/chat_message_bloc.dart';
import 'features/messages/contacts/data/repository/contact_repository.dart';
import 'features/profile/data_layer/repository/profile_client.dart';
import 'features/profile/data_layer/repository/profile_repository.dart';
import 'features/property/create_property/data_layer/property_repository.dart';
import 'features/requests/appointments/data_layer/repository/my_appointments_repository.dart';
import 'features/wallet/data_layer/repository/wallet_client.dart';
import 'features/wallet/data_layer/repository/wallet_repository.dart';

class Locator {
  static setup() async {
    // Initialize hive for local storage.
    final box = await _getHiveBoxInstance();

    GetIt.I.registerLazySingleton<UserRepositoryAPI>(
      () => UserRepositoryImpl(LocalStorageImpl(box)),
    );
    GetIt.I.registerLazySingleton<SignInRepositoryAPI>(
      () => SignInRepositoryImpl(SignInClientImpl()),
    );
    GetIt.I.registerLazySingleton<ProfileRepositoryAPI>(
      () => ProfileRepositoryFake(),
      // () => ProfileRepositoryImpl(ProfileClientImpl()),
    );
    GetIt.I.registerLazySingleton<PropertyRepositoryAPI>(
      () => PropertyRepositoryFake(),
      // () => PropertyRepositoryImpl(PropertyClientImpl()),
    );
    GetIt.I.registerLazySingleton(
      () => ChatMessageBloc(),
    );

    GetIt.I.registerLazySingleton<ContactRepository>(
      () => const ContactRepositoryFakeImpl(),
      // () => ContactRepositoryImpl(
      //   conctactClientAPI: ContactClientImpl(),
      // ),
    );

    GetIt.I.registerLazySingleton<MyAppointmentsRepositoryAPI>(
      () => MyAppointmentsRepositoryFake(),
      // () => MyAppointmentsRepositoryImpl(MyAppointmemtsClientImpl()),
    );

    GetIt.I.registerLazySingleton<ApplicationsRepositoryAPI>(
      () => ApplicationRepositoryFake(),
      // () => ApplicationRepositoryImpl(
      //    ApplicationsClientImpl(),
      // ),
    );

    GetIt.I.registerLazySingleton<WalletRepositoryAPI>(
      // () => WalletRepositoryFake(),
      () => WalletRepositoryImpl(WalletClientImpl()),
    );
  }

  static Future<Box> _getHiveBoxInstance() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(UserAdapter());
    return await Hive.openBox('gojo');
  }
}
