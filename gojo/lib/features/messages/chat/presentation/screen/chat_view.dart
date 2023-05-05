import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/features/messages/chat/presentation/bloc/chat_gen.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/chat_input.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/chat_bubbles/received_chat_bubble.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/chat_bubbles/sent_chat_bubble.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../bloc/chat_message_bloc.dart';

const loggedInUserId = "you";

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GetIt.I<ChatMessageBloc>()
          ..add(
            ChatMessageLoad(chatId: "chatId"),
          );
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ChatContent(),
      ),
    );
  }
}

class ChatContent extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ChatGenerator _chatGenerator = GetIt.I<ChatGenerator>();
  final TextEditingController _controller = TextEditingController();

  ChatContent({super.key});

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
      child: GojoParentView(
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
                            if (state.messages[index].sender.id ==
                                loggedInUserId) {
                              return GojoSentChatBubble(
                                content: state.messages[index].message,
                              );
                            } else {
                              return GojoReceivedChatBubble(
                                image: AssetImage(
                                  Resources.gojoImages.headShot,
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
                      _chatGenerator.sendMessage(ChatMessageSend());
                    }
                    _controller.text = "";
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
