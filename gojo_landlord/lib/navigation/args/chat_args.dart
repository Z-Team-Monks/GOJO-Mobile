import '../../Gojo-Mobile-Shared/core/model/user.dart';
import '../../features/messages/contacts/data/model/chat.dart';

class ChatArgs {
  final List<ChatMessage> messages;
  final User tenant;

  ChatArgs({required this.messages, required this.tenant});
}
