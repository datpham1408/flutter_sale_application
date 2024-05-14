import 'package:flutter/material.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';

class MeatScreen extends StatefulWidget {
  const MeatScreen({super.key});

  @override
  State<MeatScreen> createState() => _MeatScreenState();
}

class _MeatScreenState extends State<MeatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: itemBody(),
      ),
    );
  }

  Widget itemBody() {
    return Column(
      children: [
        itemDetailBody(image: imageBeef, title: beef),
        itemDetailBody(image: imagePork, title: pork),
        itemDetailBody(image: imageDuck, title: duck),
        itemDetailBody(image: imageChicken, title: chicken),
        itemDetailBody(image: imageGoat, title: goat),
        itemDetailBody(image: imageLamb, title: lamb),
        itemDetailBody(image: imageVenison, title: venison),
      ],
    );
  }

  Widget itemDetailBody({String? image, String? title}) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(
        children: [
          Image.asset(image ?? ''),
          Utils.instance.sizeBoxWidth(20),
          Text(title ?? '')
        ],
      ),
    );
  }
}
