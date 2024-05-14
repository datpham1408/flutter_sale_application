import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sale_application/cart/cart_screen.dart';
import 'package:flutter_sale_application/home/sale_application_home_screen.dart';
import 'package:flutter_sale_application/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  const HomeScreen({super.key, this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  User? _user;
  late ProfileScreen _profileScreen;
  final List<Widget> _screens = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: itemBottomBar(),
    );
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _profileScreen =
        ProfileScreen(user: _user);
    _screens.addAll([
      SaleApplicationHomeScreen(),
      CartScreen(),
      _profileScreen,
    ]);
  }

  Widget getProfileScreen() {
    return ProfileScreen(user: _user);
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
          icon: Icon(Icons.home),
          label: 'Trang Chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Giỏ Hàng',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Cá Nhân',
        ),
      ],
    );
  }
}
