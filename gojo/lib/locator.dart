import 'package:get_it/get_it.dart';
import 'package:gojo/features/messages/chat/data/repository/chat_repository.dart';
import 'package:gojo/features/messages/chat/presentation/bloc/chat_gen.dart';
import 'package:gojo/features/messages/chat/presentation/bloc/chat_message_bloc.dart';

import 'features/home/data_layer/repository/home_repository.dart';
import 'features/profile/data_layer/repository/profile_repository.dart';

class Locator {
  static void setup() {
    GetIt.I.registerLazySingleton<HomeRepositoryAPI>(
      () => HomeRepositoryFake(),
    );

    GetIt.I.registerLazySingleton<ProfileRepositoryAPI>(
      () => ProfileRepositoryFake(),
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
  }
}
