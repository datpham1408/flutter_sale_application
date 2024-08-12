import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/recent_conversation/recent_conversation_cubit.dart';
import 'package:flutter_sale_application/recent_conversation/recent_conversation_state.dart';
import 'package:flutter_sale_application/resources/utils.dart';

import '../model/message_chat_model.dart';

class RecentConversationScreen extends StatefulWidget {
  const RecentConversationScreen({Key? key}) : super(key: key);

  @override
  State<RecentConversationScreen> createState() =>
      _RecentConversationScreenState();
}

class _RecentConversationScreenState extends State<RecentConversationScreen> {
  final RecentConversationCubit _conversationCubit =
      getIt.get<RecentConversationCubit>();
  List<ChatMessage> list = [];
  String id = '';
  String time = '';

  @override
  void initState() {
    super.initState();
    // _conversationCubit.getListDataChat();
    // _conversationCubit.getListDataChat12();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<RecentConversationCubit>(
          create: (_) => _conversationCubit,
          child: BlocConsumer<RecentConversationCubit, RecentConversationState>(
            listener: (_, RecentConversationState state) {
              handleListener(state);
            },
            builder: (_, RecentConversationState state) {
              return itemBody();
            },
          ),
        ));
  }

  Widget itemBody() {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final ChatMessage chatMessage = list[index];
        return itemDetailBody(
            message: chatMessage.message,
            sender: chatMessage.sender,
            time: _conversationCubit.formatTime(chatMessage.timestamp));
      },
    );
  }

  Widget itemDetailBody({String? message, String? sender, String? time}) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text(time ?? ''),
          Utils.instance.sizeBoxWidth(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(sender ?? ''), Text(message ?? '')],
          ),
        ],
      ),
    );
  }

  void handleListener(RecentConversationState state) {
    if (state is GetDataChat) {
      list = state.listChat as List<ChatMessage>;
      id = state.id;
    }
    if (state is ConvertTime) {
      time = state.time;
    }
  }
}
