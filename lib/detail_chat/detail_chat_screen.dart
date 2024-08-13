import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/model/message_chat_model.dart';
import 'package:flutter_sale_application/model/user_model.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import 'detail_chat_cubit.dart';
import 'detail_chat_state.dart';

class DetailChatScreen extends StatefulWidget {
  final UserModel userModel;
  final UserModel selectedModel;

  const DetailChatScreen(
      {super.key, required this.userModel, required this.selectedModel});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final DetailChatCubit _chatCubit = getIt.get<DetailChatCubit>();
  List<ChatMessage> _chatMessages = [];
  CollectionReference? _messagesRef;
  ScrollController? controller;
  String time = '';
  List<String> timestamps = [];
  List<ChatMessage> listChatMessageReverse = [];
  String url = '';
  final ImagePicker _picker = ImagePicker();
  File imageFile = File('');

  // String path = '';
  bool checkURL = false;
  List<File> imageFiles = [];
  List<String> listUrl = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      checkChatMessage();
    });
    _messagesRef = FirebaseFirestore.instance.collection('conversations');
    _chatCubit.chatMessage(
        widget.userModel.idUser, widget.selectedModel.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedModel.userName),
      ),
      body: SafeArea(
        child: BlocProvider<DetailChatCubit>(
          create: (_) => _chatCubit,
          child: BlocConsumer<DetailChatCubit, DetailChatState>(
            listener: (_, DetailChatState state) {
              handleListener(state);
            },
            builder: (_, DetailChatState state) {
              return itemBody();
            },
          ),
        ),
      ),
    );
  }

  Widget itemBody() {
    listChatMessageReverse = _chatMessages.reversed.toList();
    var checkImage = Uri.parse(url).isAbsolute;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            controller: controller,
            itemCount: listChatMessageReverse.length,
            itemBuilder: (context, index) {
              final chatMessage = listChatMessageReverse[index];
              final sender = chatMessage.sender;
              final timestamp = chatMessage.timestamp;
              if (chatMessage.imageUrl.isNotEmpty) {
                checkURL = Uri.parse(chatMessage.imageUrl).isAbsolute;
              }
              if (sender == widget.userModel.idUser) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildChatMessageWidget(chatMessage),
                  ],
                );
              } else {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (checkURL == true)
                        Column(
                          children: [
                            Image.network(
                              chatMessage.imageUrl,
                              height: 50,
                              width: 100,
                            ),
                          ],
                        )
                      else
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(chatMessage.message),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(_formatTime(timestamp)))
                              ],
                            ),
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
                icon: const Icon(Icons.photo_library),
                onPressed: () async {
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      // imageFiles.add(File(pickedFile.path));
                      url = pickedFile.path;
                      imageFiles.add(File(pickedFile.path));
                    });
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (url.isNotEmpty &&
                      checkImage == true &&
                      _messageController.text.isEmpty) {
                    // _sendMessage(imageUrl: url);
                    pushImageFirebaseStorage();
                  } else if (url.isEmpty &&
                      _messageController.text.isNotEmpty) {
                    _sendMessage(message: _messageController.text);
                  } else {
                    _sendMessage(
                        message: _messageController.text, imageUrl: url);
                    url = '';
                  }
                },
              ),
            ],
          ),
        ),
        if (imageFiles.isNotEmpty)
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              itemCount: imageFiles.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 50,
                  width: 100,
                  child: Stack(
                    children: [
                      Image.file(
                        imageFiles[index],
                        width: 100,
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              imageFiles.removeAt(index);
                            });
                          },
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        else
          Container()
      ],
    );
  }

  void pushImageFirebaseStorage() {
    for (var url in listUrl) {
      _sendMessage(imageUrl: url);
    }
    listUrl.clear();
  }

  Widget _buildChatMessageWidget(ChatMessage chatMessage) {
    if (chatMessage.imageUrl.isNotEmpty && chatMessage.message.isEmpty) {
      if (Uri.parse(chatMessage.imageUrl).isAbsolute) {
        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Image.network(
            chatMessage.imageUrl,
            height: 50,
            width: 100,
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Image.file(
            File(chatMessage.imageUrl),
            height: 50,
            width: 100,
          ),
        );
      }
    } else if (chatMessage.imageUrl.isEmpty && chatMessage.message.isNotEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.lightBlueAccent.withOpacity(0.3),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatMessage.message,
                style: TextStyle(fontSize: 16),
              ),
              Utils.instance.sizeBoxHeight(8),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  _formatTime(chatMessage.timestamp),
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.lightBlueAccent.withOpacity(0.3),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatMessage.message,
                style: TextStyle(fontSize: 16),
              ),
              Utils.instance.sizeBoxHeight(4),
              Image.network(
                chatMessage.imageUrl,
                height: 50,
                width: 100,
              ),
              Utils.instance.sizeBoxHeight(8),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  _formatTime(chatMessage.timestamp),
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void sortMessagesByTimestamp() {
    _chatMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  Future<void> checkChatMessage() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('conversations')
        .doc('${widget.userModel.idUser}${widget.selectedModel.idUser}')
        .get();

    if (!snapshot.exists) {
      await FirebaseFirestore.instance
          .collection('conversations')
          .doc('${widget.userModel.idUser}${widget.selectedModel.idUser}')
          .set({
        'data': [],
        'id': '${widget.userModel.idUser}${widget.selectedModel.idUser}',
      });
    }
  }

  Future<void> _sendMessage({String? message, String? imageUrl}) async {
    if (widget.userModel.idUser.isNotEmpty) {
      var chatMessage = ChatMessage(
        message: message ?? '',
        imageUrl: imageUrl ?? '',
        sender: widget.userModel.idUser,
        timestamp: DateTime.now(),
      );

      _chatMessages.insert(0, chatMessage);
      try {
        await _messagesRef
            ?.doc('${widget.userModel.idUser}${widget.selectedModel.idUser}')
            .update({
          'data': FieldValue.arrayUnion([chatMessage.toJson()]),
        });
        _messageController.clear();

        if (imageUrl != null) {
          for (int i = 0; i < imageFiles.length; i++) {
            _chatCubit.uploadImageToFirebase(imageFiles[i]);
          }
        }

        _chatCubit.updateChatMessages(_chatMessages);

        sortMessagesByTimestamp();

        controller?.jumpTo(controller!.position.maxScrollExtent);

        print('Tin nhắn được gửi thành công!');
      } catch (e) {
        print('Lỗi khi gửi tin nhắn: $e');
      }
    }
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute}';
  }

  void handleListener(DetailChatState state) {
    if (state is ChatMessageData) {
      _chatMessages = state.chatMessage;
    }
    if (state is ChatMessageUpdated) {
      _chatMessages = state.chatMessages;
    }

    if (state is FireStorage) {
      imageFiles.clear();
      url = state.url;
      listUrl.add(url);
    }
  }
}
