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
        itemDetailBody(
            image: imageApple,
            title: apple,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageApple,
                  title: apple,
                  coast: 24.00);
            }),
        itemDetailBody(
            image: imageAvocado,
            title: avocado,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageAvocado,
                  title: avocado,
                  coast: 20.00);
            }),
        itemDetailBody(
            image: imageGrape,
            title: grape,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageGrape,
                  title: grape,
                  coast: 21.93);
            }),
        itemDetailBody(
            image: imageGuava,
            title: guava,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageGuava,
                  title: guava,
                  coast: 15.23);
            }),
        itemDetailBody(
            image: imageLychee,
            title: lychee,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageLychee,
                  title: lychee,
                  coast: 19.22);
            }),
        itemDetailBody(
            image: imageMango,
            title: mango,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageMango,
                  title: mango,
                  coast: 19.37);
            }),
        itemDetailBody(
            image: imagePeach,
            title: peach,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imagePeach,
                  title: peach,
                  coast: 28.65);
            }),
        itemDetailBody(
            image: imageWatermelon,
            title: watermelon,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageWatermelon,
                  title: watermelon,
                  coast: 12.65);
            }),
      ],
    );
  }

  Widget itemDetailBody({String? image, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
