import 'package:gojo/features/messages/contacts/data/model/contact.dart';

import '../../../../../Gojo-Mobile-Shared/network/base_api_client.dart';

abstract class ContactClientAPI {
  Future<List<Contact>> getContacts();
}

class ContactClientImpl extends BaseApiClient implements ContactClientAPI {
  @override
  Future<List<Contact>> getContacts() async {
    final fetchMessagesResponse = await get(
      '/chats/',
    );
    return List<Contact>.from(fetchMessagesResponse.data);
  }
}
