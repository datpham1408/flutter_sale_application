import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/profile/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit() : super(ProfileState());

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', false);
    await prefs.remove('email');
    emit(LogoutState());
  }

}