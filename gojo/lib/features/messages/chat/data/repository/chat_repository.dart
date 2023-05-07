import '../../../../../core/model/user.dart';
import '../model/chat.dart';
import 'chat_client_api.dart';

abstract class ChatRepositoryAPI {
  Future<List<ChatMessage>> getMessages(String chatId);
}

class ChatRepositoryImpl implements ChatRepositoryAPI {
  final ChatClientAPI chatClientAPI;

  const ChatRepositoryImpl({required this.chatClientAPI});

  @override
  Future<List<ChatMessage>> getMessages(String chatId) {
    return chatClientAPI.getMessages(chatId);
  }
}

class ChatRepositoryFakeImpl implements ChatRepositoryAPI {
  const ChatRepositoryFakeImpl();

  @override
  Future<List<ChatMessage>> getMessages(String chatId) {
    const user = User(
      id: "you",
      firstName: "Kebede",
      lastName: "Alemayehu",
      phoneNumber: "0949024607",
      profilePicture: "",
    );

    const sender = User(
      id: "other",
      firstName: "Kebede",
      lastName: "Alemayehu",
      phoneNumber: "0949024607",
      profilePicture: "",
    );

    const chats = [
      ChatMessage(
        id: "1",
        message: "Hey!",
        sender: user,
      ),
      ChatMessage(
        id: "2",
        message: "Are you still in town?",
        sender: user,
      ),
      ChatMessage(
        id: "3",
        message: "Yes! I am in Addis. Are you still interested?",
        sender: sender,
      ),
      ChatMessage(
        id: "4",
        message:
            "Yes I am. I will be scheduling a personal visit for tomorrow.",
        sender: user,
      ),
    ];

    return Future.delayed(const Duration(seconds: 1), () => chats);
  }
}
