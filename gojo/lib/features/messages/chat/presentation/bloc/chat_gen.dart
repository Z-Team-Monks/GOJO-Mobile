import 'dart:async';
import 'package:gojo/features/messages/chat/presentation/bloc/chat_message_bloc.dart';

class ChatGenerator {
  StreamController<String> _controller = StreamController<String>();
  final ChatMessageBloc chatMessageBloc;
  int index = 0;
  final replies = [
    "Okay, see you then!",
    "Hey! How are you?",
    "It was nice meeting you in person.",
    "See you soon!",
  ];

  ChatGenerator({required this.chatMessageBloc}) {
    Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_controller.isClosed) {
        _controller = StreamController<String>();
      }
      if (!_controller.isClosed) {
        _controller.sink.add(replies[(index++) % replies.length]);
      }
    });
    _controller.stream.listen((event) {
      chatMessageBloc.add(
        ChatMessageReceive(chatId: "1", message: event),
      );
    });
  }

  Stream<String> get stream => _controller.stream;

  sendMessage(ChatMessageSend chatMessage) {
    chatMessageBloc.add(chatMessage);
  }

  dispose() {
    _controller.close();
  }
}
