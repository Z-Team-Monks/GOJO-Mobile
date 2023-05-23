import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/model/user.dart';
import '../../../contacts/data/model/chat.dart';
import 'chat_gen.dart';

part 'chat_message_event.dart';
part 'chat_message_state.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  ChatMessageBloc() : super(const ChatMessageState()) {
    on<ChatMessageLoad>((event, emit) async {
      emit(state.copyWith(
        fetchStatus: FetchChatMessageStatus.success,
        messages: event.messages,
      ));
    });

    on<ChatMessageChange>((event, emit) {
      emit(
        state.copyWith(
          newMessage: event.message,
          fetchStatus: FetchChatMessageStatus.editing,
        ),
      );
    });

    on<ChatMessageSend>((event, emit) async {
      // TODO: use logged in user
      const user = User(
        id: 1,
        firstName: "Kebede",
        lastName: "Alemayehu",
        phoneNumber: "0949024607",
        profilePicture: "",
      );
      final messages = state.messages +
          [
            ChatMessage(
              message: state.newMessage,
              timestamp: DateTime.now().toString(),
              sender: user,
            ),
          ];

      emit(state.copyWith(
        messages: messages,
        newMessage: "",
        fetchStatus: FetchChatMessageStatus.success,
      ));
    });

    on<ChatMessageReceive>((event, emit) {
      final messages = state.messages + [event.chat];
      emit(state.copyWith(messages: messages));
    });
  }

  @override
  Future<void> close() {
    GetIt.I<ChatGenerator>().dispose();
    GetIt.I.resetLazySingleton<ChatGenerator>();
    GetIt.I.resetLazySingleton<ChatMessageBloc>();
    return super.close();
  }
}
