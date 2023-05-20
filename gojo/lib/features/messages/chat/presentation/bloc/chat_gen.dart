import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gojo/features/messages/chat/presentation/bloc/chat_message_bloc.dart';
import 'package:web_socket_channel/io.dart';

import '../../../contacts/data/model/chat.dart';

class ChatGenerator {
  final IOWebSocketChannel channel = IOWebSocketChannel.connect(
    Uri.parse("ws://localhost:8000/ws/chat/2/1/"),
  );

  final ChatMessageBloc chatMessageBloc;

  ChatGenerator({required this.chatMessageBloc}) {
    debugPrint(channel.toString());
    channel.stream.listen((event) {
      debugPrint(event);
      chatMessageBloc.add(
        ChatMessageReceive(
          chat: ChatMessage.fromJson(jsonDecode(event)),
        ),
      );
    });
  }

  Stream<dynamic> get stream => channel.stream;

  sendMessage(ChatMessageSend chatMessage) {
    debugPrint(chatMessage.message);
    channel.sink.add(jsonEncode({"content": chatMessage}));
    chatMessageBloc.add(chatMessage);
  }

  dispose() {
    channel.sink.close();
  }
}
