import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';
import '../model/chat.dart';

abstract class ChatClientAPI {
  Future<List<ChatMessage>> getMessages(String chatId);
}

class ChatClientImpl extends BaseApiClient implements ChatClientAPI {
  @override
  Future<List<ChatMessage>> getMessages(String chatId) async {
    final fetchMessagesResponse = await get(
      '/chats/$chatId/',
    );
    return List<ChatMessage>.from(fetchMessagesResponse.data);
  }
}
