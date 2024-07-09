import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String message;
  final String sender;
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ChatMessage.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final message = data['message'] as String;
    final sender = data['sender'] as String;
    final timestamp = DateTime.parse(data['timestamp'] as String);

    return ChatMessage(
      message: message,
      sender: sender,
      timestamp: timestamp,
    );
  }
}