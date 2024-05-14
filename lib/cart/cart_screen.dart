import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sale_application/canceled/canceled_screen.dart';
import 'package:flutter_sale_application/delivered/delivered_screen.dart';
import 'package:flutter_sale_application/status/status_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    StatusScreen(),
    DeliveredScreen(),
    CanceledScreen()
  ];

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: _screens[_currentIndex],
  //     ),
  //     bottomNavigationBar: itemBottomBar(),
  //   );
  // }
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
          ), systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
    );
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
          label: 'Trạng Thái Đơn Hàng',
        ),
        BottomNavigationBarItem(
          icon: SizedBox.shrink(),
          label: 'Đã Giao',
        ),
        BottomNavigationBarItem(
          icon: SizedBox.shrink(),
          label: 'Đã Huỷ',
        ),
      ],
    );
  }
}