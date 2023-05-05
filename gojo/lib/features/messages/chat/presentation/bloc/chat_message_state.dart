part of 'chat_message_bloc.dart';

enum FetchChatMessageStatus { loading, editing, success, error }

class ChatMessageState extends Equatable {
  final List<ChatMessage> messages;
  final String newMessage;
  final FetchChatMessageStatus fetchStatus;

  const ChatMessageState({
    this.messages = const [],
    this.fetchStatus = FetchChatMessageStatus.loading,
    this.newMessage = "",
  });

  ChatMessageState copyWith({
    List<ChatMessage>? messages,
    FetchChatMessageStatus? fetchStatus,
    String? newMessage,
  }) {
    return ChatMessageState(
      messages: messages ?? this.messages,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      newMessage: newMessage ?? this.newMessage,
    );
  }

  @override
  List<Object?> get props => [messages, newMessage, fetchStatus];
}
