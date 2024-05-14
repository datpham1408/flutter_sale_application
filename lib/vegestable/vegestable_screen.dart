import 'package:flutter/material.dart';

class VegetableScreen extends StatefulWidget {
  const VegetableScreen({super.key});

  @override
  State<VegetableScreen> createState() => _VegetableScreenState();
}

class _VegetableScreenState extends State<VegetableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: itemBody(),
      ),
    );
  }

  Widget itemBody() {
    return Container();
  }
}
