import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sale_application/message/chat_screen.dart';
import 'package:flutter_sale_application/recent_conversation/resent_conversation_screen.dart';

import 'model/user_model.dart';

class HomeChatScreen extends StatefulWidget {
  final UserModel model;

  const HomeChatScreen({super.key, required this.model});

  @override
  State<HomeChatScreen> createState() => _HomeChatScreenState();
}

class _HomeChatScreenState extends State<HomeChatScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kBottomNavigationBarHeight),
            child: itemBottomBar(),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      const RecentConversationScreen(),
      ChatScreen(entity: widget.model),
    ]);
  }

  Widget itemBottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: SizedBox.shrink(),
          label: 'Recent Conversation',
        ),
        BottomNavigationBarItem(
          icon: SizedBox.shrink(),
          label: 'Research',
        ),
      ],
    );
  }
}
