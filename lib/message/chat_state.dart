import 'package:flutter_sale_application/entity/user_entity.dart';

class ChatState {}

class GetUser extends ChatState{
  final UserEntity entity;

  GetUser({required this.entity});
}
class ConvertTime extends ChatState{
  final String time;

  ConvertTime({required this.time});
}