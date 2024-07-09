import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/resources/string.dart';

import '../model/message_chat_model.dart';
import 'chat_cubit.dart';
import 'chat_state.dart';

class ChatScreen extends StatefulWidget {
  final UserEntity? entity;

  const ChatScreen({super.key, required this.entity});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatCubit _chatCubit = getIt.get<ChatCubit>();
  CollectionReference? _messagesRef;
  final List<ChatMessage> _chatMessages = [];
  UserEntity userEntity = UserEntity();
  String time = '';

  @override
  void initState() {
    super.initState();
    _chatCubit.getUser(widget.entity?.email ?? '');

    Firebase.initializeApp().then(
      (firebaseApp) {
        _messagesRef = FirebaseFirestore.instance.collection("message");
        _messagesRef?.snapshots().listen(
          (snapshot) {
            for (var change in snapshot.docChanges) {
              final chatMessage = ChatMessage.fromSnapshot(change.doc);
              setState(() {
                _chatMessages.add(chatMessage);
              });
            }
          },
        );
      },
    );
  }

  Future<void> _sendMessage(String message) async {
    if (userEntity.selected == user) {
      final chatMessage = ChatMessage(
        message: message,
        sender: user,
        timestamp: DateTime.now(),
      );

      await _messagesRef?.add(chatMessage.toJson());
      _messageController.clear();
    }
    if (userEntity.selected == store) {
      final chatMessage = ChatMessage(
          message: message, sender: store, timestamp: DateTime.now());

      await _messagesRef?.add(chatMessage.toJson());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: BlocProvider<ChatCubit>(
        create: (_) => _chatCubit,
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (_, ChatState state) {
            handleListener(state);
          },
          builder: (_, ChatState state) {
            return itemBody();
          },
        ),
      ),
    );
  }

  Widget itemBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: _chatMessages.length,
            itemBuilder: (context, index) {
              final chatMessage = _chatMessages[index];
              final sender = chatMessage.sender;
              _chatCubit.formatTime(chatMessage.timestamp);
              if (sender == userEntity.selected) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Text(time),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          title: Text(chatMessage.sender),
                          subtitle: Text(chatMessage.message),
                        ),
                      ),

                    ],
                  ),
                );
              } else {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(time),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: ListTile(
                          title: Text(chatMessage.sender),
                          subtitle: Text(chatMessage.message),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a message',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  _sendMessage(_messageController.text);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void handleListener(ChatState state) {
    if (state is GetUser) {
      userEntity = state.entity;
    }
    if (state is ConvertTime) {
      setState(() {
        time = state.time;
      });
    }
  }
}
