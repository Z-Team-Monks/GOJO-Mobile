part of 'chat_message_bloc.dart';

abstract class ChatMessageEvent extends Equatable {}

class ChatMessageLoad extends ChatMessageEvent {
  final List<ChatMessage> messages;

  ChatMessageLoad({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatMessageChange extends ChatMessageEvent {
  final String message;

  ChatMessageChange({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatMessageSend extends ChatMessageEvent {
  final String message;

  ChatMessageSend(this.message);

  @override
  List<Object> get props => [];
}

class ChatMessageReceive extends ChatMessageEvent {
  final ChatMessage chat;

  ChatMessageReceive({required this.chat});

  @override
  List<Object> get props => [chat];
}
