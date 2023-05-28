import 'package:equatable/equatable.dart';

import '../../../../../core/model/user.dart';

class ChatMessage extends Equatable {
  final String message;
  final User sender;
  final bool fromMe;
  final String timestamp;

  const ChatMessage({
    required this.message,
    required this.sender,
    required this.timestamp,
    required this.fromMe,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['content'],
      timestamp: json['timestamp'],
      sender: User.fromJson(json['sender']),
      fromMe: json['from_me']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
    };
  }

  @override
  List<Object?> get props => [timestamp, message, sender, fromMe];
}
