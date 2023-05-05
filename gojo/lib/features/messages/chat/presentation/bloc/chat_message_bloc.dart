import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/features/messages/chat/data/repository/chat_repository.dart';

import '../../../../../core/model/user.dart';
import '../../data/model/chat.dart';
import 'chat_gen.dart';

part 'chat_message_event.dart';
part 'chat_message_state.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final ChatRepositoryAPI chatRepository;

  ChatMessageBloc({required this.chatRepository})
      : super(const ChatMessageState()) {
    on<ChatMessageLoad>((event, emit) async {
      emit(state.copyWith(fetchStatus: FetchChatMessageStatus.loading));
      try {
        final messages = await chatRepository.getMessages(event.chatId);
        emit(
          state.copyWith(
            messages: messages,
            fetchStatus: FetchChatMessageStatus.success,
          ),
        );
      } catch (e) {
        emit(state.copyWith(fetchStatus: FetchChatMessageStatus.error));
      }
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
        id: "you",
        firstName: "Kebede",
        lastName: "Alemayehu",
        phoneNumber: "0949024607",
        profilePicture: "",
      );
      final messages = state.messages +
          [
            ChatMessage(
              id: "you",
              message: state.newMessage,
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
      const user = User(
        id: "other",
        firstName: "Kebede",
        lastName: "Alemayehu",
        phoneNumber: "0949024607",
        profilePicture: "",
      );
      final messages = state.messages +
          [
            ChatMessage(
              id: "other",
              message: event.message,
              sender: user,
            ),
          ];
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
