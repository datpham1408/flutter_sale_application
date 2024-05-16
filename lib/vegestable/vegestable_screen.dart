import 'package:flutter/material.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';

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
    return Column(
      children: [
        itemDetailBody(
            image: imageAsparagus,
            title: asparagus,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageAsparagus,
                  title: asparagus,
                  coast: 34.00);
            }),
        itemDetailBody(
            image: imageBroccoli,
            title: broccoli,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageBroccoli,
                  title: broccoli,
                  coast: 10.00);
            }),
        itemDetailBody(
            image: imageCabbage,
            title: cabbage,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageCabbage,
                  title: cabbage,
                  coast: 21.93);
            }),
        itemDetailBody(
            image: imageKale,
            title: kale,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageKale,
                  title: kale,
                  coast: 15.74);
            }),
        itemDetailBody(
            image: imageRadish,
            title: radish,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageRadish,
                  title: radish,
                  coast: 9.22);
            }),
        itemDetailBody(
            image: imageSpinach,
            title: spinach,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageSpinach,
                  title: spinach,
                  coast: 19.37);
            }),
        itemDetailBody(
            image: imageWatercress,
            title: watercress,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageWatercress,
                  title: watercress,
                  coast: 8.65);
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
