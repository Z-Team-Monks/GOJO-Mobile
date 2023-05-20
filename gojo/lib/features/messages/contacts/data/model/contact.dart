import 'package:equatable/equatable.dart';
import 'package:gojo/features/messages/contacts/data/model/chat.dart';

import '../../../../../core/model/user.dart';

class Contact extends Equatable {
  final User sender;
  final List<ChatMessage> chatMessages;
  final int unreadMessages;

  const Contact({
    required this.sender,
    required this.chatMessages,
    required this.unreadMessages,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      sender: User.fromJson(json['user_1']),
      chatMessages: List<ChatMessage>.from(
        json['messages'].map(
          (x) => ChatMessage.fromJson(x),
        ),
      ),
      unreadMessages: json['unseen_count'],
    );
  }

  @override
  List<Object?> get props => [sender, chatMessages, unreadMessages];
}
