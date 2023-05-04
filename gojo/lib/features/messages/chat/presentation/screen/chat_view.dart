import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/chat_input.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/chat_bubbles/received_chat_bubble.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/chat_bubbles/sent_chat_bubble.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
        child: Column(
      children: [
        ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            const GojoSentChatBubble(content: "Hi!"),
            const GojoSentChatBubble(content: "Are you still in town?"),
            GojoReceivedChatBubble(
              image: AssetImage(Resources.gojoImages.headShot),
              content: "Yes! I am in Addis. Are you still interested?",
            ),
            const GojoSentChatBubble(
              content:
                  "Yes I am. I will be scheduling a personal visit for tomorrow.",
            ),
          ],
        ),
        const Spacer(),
        GojoChatInput(label: "Message", onSendIconPressed: () {}),
      ],
    ));
  }
}
