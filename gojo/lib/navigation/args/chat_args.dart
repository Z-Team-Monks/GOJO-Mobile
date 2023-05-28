import '../../core/model/user.dart';
import '../../features/messages/contacts/data/model/chat.dart';

class ChatArgs {
  final List<ChatMessage> messages;
  final User landlord;

  ChatArgs({required this.messages, required this.landlord});
}
