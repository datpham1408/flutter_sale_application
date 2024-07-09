import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sale_application/cart/cart_screen.dart';
import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/home/sale_application_home_screen.dart';
import 'package:flutter_sale_application/message/message_screen.dart';
import 'package:flutter_sale_application/profile/profile_screen.dart';

import 'entity/user_entity.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity userEntity;

  const HomeScreen({super.key, required this.userEntity});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [];

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: PageView(),
        child: PageView(
          controller: _pageController,
          children: _screens,
        ),
      ),
      bottomNavigationBar: itemBottomBar(),
    );
  }

  @override
  void initState() {
    super.initState();
    // _user = widget.user;
    _screens.addAll([
      SaleApplicationHomeScreen(userEntity: widget.userEntity),
      const CartScreen(),
      MessageScreen(entity: widget.userEntity),
      ProfileScreen(
        userEntity: widget.userEntity,
      ),
    ]);
  }

  Widget itemBottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(Icons.home),
          label: 'Trang Chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Đơn Hàng',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Tin Nhắn',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Cá Nhân',
        ),
      ],
    );
  }
}
