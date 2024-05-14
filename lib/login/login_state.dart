import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';

class LoginState{}

class LoginCheckIsEmptyEmail extends LoginState {}

class LoginCheckIsEmptyPassword extends LoginState {}

class ValidateEmailState extends LoginState {}

class ValidatePasswordState extends LoginState {}

class LoginSuccessState extends LoginState{

}

class LoginErrorState extends LoginState{
}

class Authenticated extends LoginState{
  final String email;

  Authenticated({required this.email});
}

class CheckBoxState extends LoginState{
  final bool? isSelected;

  CheckBoxState({required this.isSelected});
}
class LoginWithGoogleSuccessState extends LoginState{
  final User user;

  LoginWithGoogleSuccessState({required this.user});
}
class LoginWithGoogleErrorState extends LoginState{

}