import 'package:equatable/equatable.dart';

import '../../../../../core/model/user.dart';

class ChatMessage extends Equatable {
  final String id;
  final String message;
  final User sender;

  const ChatMessage({
    required this.id,
    required this.message,
    required this.sender,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      message: json['message'],
      sender: User.fromJson(json['sender']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "message": message,
      "sender": sender.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, message, sender];
}
