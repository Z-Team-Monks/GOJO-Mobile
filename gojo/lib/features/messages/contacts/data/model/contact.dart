import 'package:equatable/equatable.dart';

import '../../../../../core/model/user.dart';
import 'chat.dart';

class Contact extends Equatable {
  final User landlord;
  final User tenant;
  final List<ChatMessage> chatMessages;
  final int unreadMessages;

  const Contact({
    required this.tenant,
    required this.landlord,
    required this.chatMessages,
    required this.unreadMessages,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      landlord: User.fromJson(json['landlord']),
      tenant: User.fromJson(json['tenant']),
      chatMessages: List<ChatMessage>.from(
        json['messages'].map(
          (x) => ChatMessage.fromJson(x),
        ),
      ),
      unreadMessages: json['unseen_count'],
    );
  }

  @override
  List<Object?> get props => [landlord, tenant, chatMessages, unreadMessages];
}
