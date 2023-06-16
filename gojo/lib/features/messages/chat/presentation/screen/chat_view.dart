import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:web_socket_channel/io.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/chat_input.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/chat_bubbles/received_chat_bubble.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/chat_bubbles/sent_chat_bubble.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/core/model/user.dart';
import '../../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../contacts/data/model/chat.dart';
import '../bloc/chat_message_bloc.dart';

class ChatView extends StatelessWidget {
  final List<ChatMessage> messages;
  final User landlord;

  const ChatView({
    super.key,
    required this.messages,
    required this.landlord,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.I<ChatMessageBloc>()
          ..add(
            ChatMessageLoad(
              messages: messages,
            ),
          );
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ChatContent(landlord: landlord),
      ),
    );
  }
}

class ChatContent extends StatefulWidget {
  final User landlord;

  const ChatContent({super.key, required this.landlord});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  final ScrollController _scrollController = ScrollController();
  late final IOWebSocketChannel _channel;
  final TextEditingController _controller = TextEditingController();
  late final ChatMessageBloc chatMessageBloc = GetIt.I<ChatMessageBloc>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final tenant = await GetIt.I<UserRepositoryAPI>().getUser();
      _channel = IOWebSocketChannel.connect(
        Uri.parse(
          "ws://192.168.28.207:8000/ws/chat/${tenant!.id}/${widget.landlord.id}/",
        ),
      );
      addListener();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatMessageBloc, ChatMessageState>(
      listener: (context, state) {
        if (state.fetchStatus == FetchChatMessageStatus.success) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeInOut,
          );
        }
      },
      child: BlocBuilder<ChatMessageBloc, ChatMessageState>(
        builder: (context, state) {
          return GojoParentView(
            label: "${widget.landlord.firstName} ${widget.landlord.lastName}",
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        BlocBuilder<ChatMessageBloc, ChatMessageState>(
                          builder: (context, state) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.messages.length,
                              itemBuilder: (context, index) {
                                if (state.messages[index].fromMe) {
                                  return GojoSentChatBubble(
                                    content: state.messages[index].message,
                                  );
                                } else {
                                  return GojoReceivedChatBubble(
                                    image: CachedNetworkImageProvider(
                                      widget.landlord.profilePicture,
                                    ),
                                    content: state.messages[index].message,
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ChatMessageBloc, ChatMessageState>(
                  builder: (context, state) {
                    return GojoChatInput(
                      label: "Message",
                      controller: _controller,
                      onChanged: (value) {
                        BlocProvider.of<ChatMessageBloc>(context).add(
                          ChatMessageChange(message: value),
                        );
                      },
                      onSendIconPressed: () {
                        if (state.newMessage.isNotEmpty) {
                          sendMessage(
                            ChatMessageSend(state.newMessage),
                          );
                        }
                        _controller.text = "";
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void addListener() {
    _channel.stream.listen((event) {
      debugPrint(event);
      chatMessageBloc.add(
        ChatMessageReceive(
          chat: ChatMessage(
            message: jsonDecode(event)['message'],
            fromMe: false,
            timestamp: DateTime.now().toIso8601String(),
            sender: widget.landlord,
          ),
        ),
      );
    });
  }

  sendMessage(ChatMessageSend chatMessage) {
    debugPrint(chatMessage.message);
    _channel.sink.add(jsonEncode({"content": chatMessage.message}));
    chatMessageBloc.add(chatMessage);
  }

  @override
  dispose() {
    _channel.sink.close();
    GetIt.I.resetLazySingleton<ChatMessageBloc>();
    super.dispose();
  }
}
