import 'package:flutter_sale_application/entity/user_entity.dart';

class ChatGroupState {}

class GetUser extends ChatGroupState{
  final UserEntity entity;

  GetUser({required this.entity});
}
class ConvertTime extends ChatGroupState{
  final String time;

  ConvertTime({required this.time});
}