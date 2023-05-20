import 'package:equatable/equatable.dart';

import '../../../../../core/model/user.dart';

class ChatMessage extends Equatable {
  final String message;
  final User sender;
  final String timestamp;

  const ChatMessage({
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['content'],
      timestamp: json['timestamp'],
      sender: User.fromJson(json['sender']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
    };
  }

  @override
  List<Object?> get props => [timestamp, message, sender];
}
