import 'package:gojo/features/messages/contacts/data/model/contact.dart';

import '../../../../../core/model/user.dart';
import '../model/chat.dart';
import 'contact_client_api.dart';

abstract class ContactRepository {
  Future<List<Contact>> getContacts();
}

class ContactRepositoryImpl implements ContactRepository {
  final ContactClientAPI conctactClientAPI;

  const ContactRepositoryImpl({required this.conctactClientAPI});

  @override
  Future<List<Contact>> getContacts() {
    return conctactClientAPI.getContacts();
  }
}

class ContactRepositoryFakeImpl implements ContactRepository {
  const ContactRepositoryFakeImpl();

  @override
  Future<List<Contact>> getContacts() {
    const user = User(
      id: 1,
      firstName: "Kebede",
      lastName: "Alemayehu",
      phoneNumber: "0949024607",
      profilePicture: "",
    );

    const sender = User(
      id: 1,
      firstName: "Kebede",
      lastName: "Alemayehu",
      phoneNumber: "0949024607",
      profilePicture: "",
    );

    final chats = [
      ChatMessage(
        message: "Hey!",
        sender: user,
        timestamp: "9:00",
      ),
      ChatMessage(
        message: "Are you still in town?",
        timestamp: "Mar 21, 9:00",
        sender: user,
      ),
      ChatMessage(
        message: "Yes! I am in Addis. Are you still interested?",
        timestamp: "Mar 20, 8:00",
        sender: sender,
      ),
      ChatMessage(
        timestamp: "Mar 20, 7:00",
        message:
            "Yes I am. I will be scheduling a personal visit for tomorrow.",
        sender: user,
      ),
    ];

    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        Contact(
          sender: sender,
          chatMessages: chats,
          unreadMessages: 5,
        ),
        Contact(
          sender: sender,
          chatMessages: chats,
          unreadMessages: 5,
        )
      ],
    );
  }
}
