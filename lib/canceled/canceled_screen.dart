import 'package:flutter/material.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({Key? key}) : super(key: key);

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('canceled');
  }
}


/// MVVM
/// Model -> user khong thay duoc
///
/// ViewModel -> user khong thay duoc
///
/// View -> user tuong tac duoc
///
/// Use case:
/// User login
/// 1. User input email
/// 2. Input password
/// 3. Click button submit
///
/// View -> ban event -> ViewModel
///