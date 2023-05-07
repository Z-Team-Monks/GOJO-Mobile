part of 'chat_message_bloc.dart';

abstract class ChatMessageEvent extends Equatable {}

class ChatMessageLoad extends ChatMessageEvent {
  final String chatId;

  ChatMessageLoad({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class ChatMessageChange extends ChatMessageEvent {
  final String message;

  ChatMessageChange({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatMessageSend extends ChatMessageEvent {
  ChatMessageSend();

  @override
  List<Object> get props => [];
}

class ChatMessageReceive extends ChatMessageEvent {
  final String chatId;
  final String message;

  ChatMessageReceive({required this.chatId, required this.message});

  @override
  List<Object> get props => [chatId, message];
}
