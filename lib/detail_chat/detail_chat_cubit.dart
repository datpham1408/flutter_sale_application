import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/detail_chat/detail_chat_state.dart';

import '../model/message_chat_model.dart';

class DetailChatCubit extends Cubit<DetailChatState> {
  DetailChatCubit() : super(DetailChatState());

  // CollectionReference? _messagesRef;
  List<ChatMessage> list = [];

  Future<void> chatMessage(String idUser, String idSelectedUser) async {
    int userNum = int.parse(idUser);
    int selectedUserNum = int.parse(idSelectedUser);

    String doc = userNum < selectedUserNum
        ? '$idUser$idSelectedUser'
        : '$idSelectedUser$idUser';

    var messagesRef = await FirebaseFirestore.instance
        .collection('conversations')
        .doc(doc)
        .get();

    Map<String, dynamic>? data = messagesRef.data();

    List<dynamic> message = data?['data'];

    for (var item in message) {
      if (item is Map<String, dynamic>) {
        list.add(ChatMessage.fromJson(item));
      }
    }

    emit(ChatMessageData(chatMessage: list));
  }

  void updateChatMessages(List<ChatMessage> chatMessages) {
    emit(ChatMessageUpdated(chatMessages: chatMessages));
  }

  Future<void> uploadImageToFirebase(File imageFile) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('abc')
          .child(imageFile.path.split('/').last);

      final metadata = SettableMetadata(
        customMetadata: {'type': imageFile.path},
      );

      TaskSnapshot task = await ref.putFile(imageFile, metadata);
      var metaData = task.metadata;
      String imageUrl = await ref.getDownloadURL();
      emit(FireStorage(url: imageUrl));
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }
  }
}
