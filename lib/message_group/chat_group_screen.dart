// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_sale_application/entity/user_entity.dart';
// import 'package:flutter_sale_application/main.dart';
//
// import '../model/message_chat_model.dart';
// import '../model/user_model.dart';
// import 'chat_group_cubit.dart';
// import 'chat_group_state.dart';
//
// class ChatGroupScreen extends StatefulWidget {
//   final UserModel? entity;
//
//   const ChatGroupScreen({super.key, required this.entity});
//
//   @override
//   State<ChatGroupScreen> createState() => _ChatGroupScreenState();
// }
//
// class _ChatGroupScreenState extends State<ChatGroupScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatGroupCubit _chatGroupCubit = getIt.get<ChatGroupCubit>();
//   CollectionReference? _messagesRef;
//   final List<ChatMessage> _chatMessages = [];
//
//   // UserEntity userEntity = UserEntity();
//   String time = '';
//   List<String> timestamps = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // _chatGroupCubit.getUser(widget.entity?.email ?? '');
//
//     Firebase.initializeApp().then(
//       (firebaseApp) {
//         _messagesRef = FirebaseFirestore.instance.collection("group");
//         _messagesRef?.snapshots().listen(
//           (snapshot) {
//             for (var change in snapshot.docChanges) {
//               final chatMessage = ChatMessage.fromJson(change.doc.data() as Map<String,dynamic>);
//               setState(() {
//                 _chatMessages.add(chatMessage);
//                 timestamps
//                     .add(_chatGroupCubit.formatTime(chatMessage.timestamp));
//               });
//             }
//             _sortMessagesByTimestamp();
//           },
//         );
//       },
//     );
//   }
//
//   Future<void> _sendMessage(String message) async {
//     final chatMessage = ChatMessage(
//       message: message,
//       sender: widget.entity?.userName ?? '',
//       timestamp: DateTime.now(),
//     );
//
//     await _messagesRef?.add(chatMessage.toJson());
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ChatGroup Screen'),
//       ),
//       body: BlocProvider<ChatGroupCubit>(
//         create: (_) => _chatGroupCubit,
//         child: BlocConsumer<ChatGroupCubit, ChatGroupState>(
//           listener: (_, ChatGroupState state) {
//             handleListener(state);
//           },
//           builder: (_, ChatGroupState state) {
//             return itemBody();
//           },
//         ),
//       ),
//     );
//   }
//
//   void _sortMessagesByTimestamp() {
//     _chatMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
//     timestamps = _chatMessages
//         .map((message) => _chatGroupCubit.formatTime(message.timestamp))
//         .toList();
//   }
//
//   Widget itemBody() {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             reverse: true,
//             itemCount: _chatMessages.length,
//             itemBuilder: (context, index) {
//               final chatMessage = _chatMessages[index];
//               final sender = chatMessage.sender;
//               final timestamp = timestamps[index];
//               if (sender == widget.entity?.userName) {
//                 return Align(
//                   alignment: Alignment.centerRight,
//                   child: Column(
//                     children: [
//                       Text(timestamp),
//                       Directionality(
//                         textDirection: TextDirection.rtl,
//                         child: ListTile(
//                           title: Text(chatMessage.sender),
//                           subtitle: Text(chatMessage.message),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 return Align(
//                   alignment: Alignment.centerLeft,
//                   child: Column(
//                     children: [
//                       Text(timestamp),
//                       Directionality(
//                         textDirection: TextDirection.ltr,
//                         child: ListTile(
//                           title: Text(chatMessage.sender),
//                           subtitle: Text(chatMessage.message),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _messageController,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter a message',
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send),
//                 onPressed: () {
//                   _sendMessage(_messageController.text);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   void handleListener(ChatGroupState state) {
//     // if (state is GetUser) {
//     //   userEntity = state.entity;
//     // }
//   }
// }
