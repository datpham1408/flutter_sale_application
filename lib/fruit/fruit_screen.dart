import 'package:flutter/material.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({super.key});

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
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
        itemDetailBody(image: imageApple, title: apple),
        itemDetailBody(image: imageAvocado , title: avocado),
        itemDetailBody(image: imageGrape, title: grape),
        itemDetailBody(image: imageGuava, title: guava),
        itemDetailBody(image: imageLychee, title: lychee),
        itemDetailBody(image: imageMango, title: mango),
        itemDetailBody(image: imagePeach, title: peach),
        itemDetailBody(image: imageWatermelon, title: watermelon),
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
