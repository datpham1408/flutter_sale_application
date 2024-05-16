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
        itemDetailBody(
            image: imageBeef,
            title: beef,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageBeef,
                  title: beef,
                  coast: 123.00);
            }),
        itemDetailBody(
            image: imagePork,
            title: pork,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imagePork,
                  title: pork,
                  coast: 60.00);
            }),
        itemDetailBody(
            image: imageDuck,
            title: duck,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageDuck,
                  title: duck,
                  coast: 28.33);
            }),
        itemDetailBody(
            image: imageChicken,
            title: chicken,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageChicken,
                  title: chicken,
                  coast: 35.74);
            }),
        itemDetailBody(
            image: imageGoat,
            title: goat,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageGoat,
                  title: goat,
                  coast: 90.22);
            }),
        itemDetailBody(
            image: imageLamb,
            title: lamb,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageLamb,
                  title: lamb,
                  coast: 170.37);
            }),
        itemDetailBody(
            image: imageVenison,
            title: venison,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageVenison,
                  title: venison,
                  coast: 89.65);
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
