import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/message/chat_state.dart';
import 'package:intl/intl.dart';

import '../model/user_model.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());
  List<UserModel> listUser = [];

  Future<void> getListData() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('user').get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      String documentId = doc.id;
      String password = data['password'];
      String age = data['age'];
      String userName = data['user_name'];
      String role = data['role'];
      String phone = data['phone'];
      String idUser = data['id'];

      var userModel = UserModel(
        userName: userName,
        phone: phone,
        password: password,
        age: age,
        role: role,
        id: documentId,
        idUser: idUser,
      );

      listUser.add(userModel);
    }
    emit(GetUser(entity: listUser));
  }

  String formatTime(DateTime time) {
    String formattedTime = DateFormat('HH:mm').format(time);
    emit(ConvertTime(time: formattedTime));
    return formattedTime;
  }
}
