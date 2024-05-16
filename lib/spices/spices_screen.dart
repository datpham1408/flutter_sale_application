import 'package:flutter/material.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';

class SpicesScreen extends StatefulWidget {
  const SpicesScreen({super.key});

  @override
  State<SpicesScreen> createState() => _SpicesScreenState();
}

class _SpicesScreenState extends State<SpicesScreen> {
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
            image: imageSalt,
            title: salt,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageSalt,
                  title: salt,
                  coast: 34.00);
            }),
        itemDetailBody(
            image: imageSauce,
            title: sauce,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageSauce,
                  title: sauce,
                  coast: 15.00);
            }),
        itemDetailBody(
            image: imageSoySauce,
            title: soySauce,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageSoySauce,
                  title: soySauce,
                  coast: 21.23);
            }),
        itemDetailBody(
            image: imageSugar,
            title: sugar,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageSugar,
                  title: sugar,
                  coast: 15.54);
            }),
        itemDetailBody(
            image: imageMSG,
            title: msg,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context, image: imageMSG, title: msg, coast: 29.22);
            }),
        itemDetailBody(
            image: imageCondiment,
            title: condiment,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageCondiment,
                  title: condiment,
                  coast: 19.73);
            }),
        itemDetailBody(
            image: imagePepper,
            title: pepper,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imagePepper,
                  title: pepper,
                  coast: 38.62);
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
