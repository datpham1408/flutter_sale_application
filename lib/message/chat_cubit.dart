import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/message/chat_state.dart';
import 'package:flutter_sale_application/resources/hive_key.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class ChatCubit extends Cubit<ChatState>{
  ChatCubit() : super(ChatState());

  Future<void> getUser(String email) async{
    final Box<UserEntity> box = await Hive.openBox<UserEntity>(HiveKey.user);
    final List<UserEntity> list = box.values.toList();
    final UserEntity userEntity = list.firstWhere((element) => element.email == email);

    emit(GetUser(entity: userEntity));
  }

  String formatTime(DateTime time) {
    String formattedTime = DateFormat('HH:mm').format(time);
    emit(ConvertTime(time: formattedTime));
    return formattedTime;

  }
}