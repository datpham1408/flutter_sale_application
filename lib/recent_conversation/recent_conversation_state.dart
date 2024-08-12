

class RecentConversationState {}

class GetDataChat extends RecentConversationState {
  final List<dynamic> listChat;
  final String id;
  GetDataChat({required this.listChat,required this.id});
}

class ConvertTime extends RecentConversationState {
  final String time;

  ConvertTime({required this.time});
}