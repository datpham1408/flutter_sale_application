import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/model/message_chat_model.dart';
import 'package:flutter_sale_application/recent_conversation/recent_conversation_state.dart';
import 'package:intl/intl.dart';

class RecentConversationCubit extends Cubit<RecentConversationState> {
  RecentConversationCubit() : super(RecentConversationState());

  Future<void> getListDataChat() async {
    final querySnapshot =
    await FirebaseFirestore.instance.collection('conversations').get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      String id = doc.id;
      List<dynamic> listChat = data['data'];
      List<ChatMessage> convertData = [];
      for (var item in listChat) {
        if (item is Map<String, dynamic>) {
          convertData.add(ChatMessage.fromJson(item));
        }
      }
      String idChat = data['id'];
      emit(GetDataChat(listChat: convertData, id: idChat));
    }
  }

  Future<void> getListDataChat12() async {
    final querySnapshot =
   await FirebaseFirestore.instance.collection('conversations').doc('12').get();
    var i =0;
  }

  String formatTime(DateTime time) {
    String formattedTime = DateFormat('HH:mm').format(time);
    emit(ConvertTime(time: formattedTime));
    return formattedTime;
  }

}
