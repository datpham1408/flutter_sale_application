import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String message;
  String imageUrl;
  final String sender;
  final DateTime timestamp;

  ChatMessage({
    required this.imageUrl,
    required this.message,
    required this.sender,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'timestamp': timestamp,
      'imageUrl' : imageUrl
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      imageUrl: json['imageUrl'] as String,
      message: json['message'] as String,
      sender: json['sender'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

// factory ChatMessage.fromSnapshot(DocumentSnapshot snapshot) {
//   final data = snapshot.data() as Map<String, dynamic>;
//   final List<dynamic> listData = data['data'];
//   List<ChatMessage>convertData = [];
//   for(var item in listData){
//     if(item is Map<String,dynamic>){
//       convertData.add(ChatMessage.fromJson(item));
//     }
//   }
// final message = data['message'] as String;
// final sender = data['sender'] as String;
// final timestamp = DateTime.parse(data['timestamp'] as String);

// return ChatMessage(
//   message: message,
//   sender: sender,
//   timestamp: timestamp,
// );
// }
}
