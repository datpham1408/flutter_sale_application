import 'package:flutter_sale_application/model/message_chat_model.dart';

class DetailChatState {}


class ChatMessageData extends DetailChatState{
  final List<ChatMessage> chatMessage;

  ChatMessageData({required this.chatMessage});
}

class ChatMessageUpdated extends DetailChatState {
  final List<ChatMessage> chatMessages;
  ChatMessageUpdated({required this.chatMessages});
}

class FireStorage extends DetailChatState{
  final String url;

  FireStorage({required this.url});
}

