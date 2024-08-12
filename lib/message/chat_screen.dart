import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';
import 'chat_cubit.dart';
import 'chat_state.dart';

class ChatScreen extends StatefulWidget {
  final UserModel entity;

  const ChatScreen({super.key, required this.entity});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatCubit _chatCubit = getIt.get<ChatCubit>();

  List<UserModel>? listUser;

  @override
  void initState() {
    super.initState();
    _chatCubit.getListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return listUser != null
        ? ListView.builder(
            itemCount: listUser?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              UserModel? userModel = listUser?[index];

              if (userModel?.id == widget.entity.id) {
                return Container();
              }
              return GestureDetector(
                onTap: (){
                  handleItemClickDetail(userModel: widget.entity,selectedModel: userModel);
                },
                child: itemDetailBody(
                  userName: userModel?.userName,
                  email: userModel?.id,
                ),
              );
            },
          )
        : Container();
  }

  Widget itemDetailBody({String? userName, String? email}) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360), color: Colors.grey),
            child: Center(child: Text(getLastInitial(userName ?? ''))),
          ),
          Utils.instance.sizeBoxWidth(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName ?? ''),
              Text(email ?? ''),
            ],
          )
        ],
      ),
    );
  }

  String getLastInitial(String fullName) {
    List<String> nameParts = fullName.trim().split(' ');

    String lastName = nameParts.last;

    return lastName[0];
  }

  void handleListener(ChatState state) {
    if (state is GetUser) {
      listUser = state.entity;
    }
  }

  void handleItemClickDetail({UserModel? userModel, UserModel? selectedModel}) {
    GoRouter.of(context).pushNamed(
      routerNameDetailChat,
      extra: {
        'userModel': userModel,
        'modelSelected': selectedModel,
      },
    );
  }
}
