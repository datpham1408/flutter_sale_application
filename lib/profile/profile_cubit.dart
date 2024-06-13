import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/profile/profile_state.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/user_entity.dart';
import '../resources/hive_key.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit() : super(ProfileState());

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', false);
    await prefs.remove('email');
    emit(LogoutState());
  }

  Future<void> getDataUser(String? email) async {
    final Box<UserEntity> box = await Hive.openBox<UserEntity>(HiveKey.user);
    final List<UserEntity> listEntity = box.values.toList();
    final UserEntity userEntity = listEntity.firstWhere((entity) => entity.email == email);


    emit(GetUser(entity: userEntity));
  }


}