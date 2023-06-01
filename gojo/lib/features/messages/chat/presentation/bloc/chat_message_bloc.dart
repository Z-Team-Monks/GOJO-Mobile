import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../contacts/data/model/chat.dart';

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
      final user = await GetIt.I<UserRepositoryAPI>().getUser();
      final messages = state.messages +
          [
            ChatMessage(
              message: state.newMessage,
              timestamp: DateTime.now().toString(),
              sender: user!,
              fromMe: true,
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
}
