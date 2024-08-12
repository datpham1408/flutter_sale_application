import '../model/user_model.dart';

class ChatState {}

class GetUser extends ChatState {
  final List<UserModel>? entity;

  GetUser({this.entity});
}

class ConvertTime extends ChatState {
  final String time;

  ConvertTime({required this.time});
}
