import '../entity/user_entity.dart';

class ProfileState{}

class LogoutState extends ProfileState{
}
class GetUser extends ProfileState {
  final UserEntity entity;

  GetUser({required this.entity});
}