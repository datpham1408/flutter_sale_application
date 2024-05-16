import 'package:flutter/material.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';

class EggScreen extends StatefulWidget {
  const EggScreen({super.key});

  @override
  State<EggScreen> createState() => _EggScreenState();
}

class _EggScreenState extends State<EggScreen> {
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
            image: imageEgg,
            title: eggChicken,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageEgg,
                  title: eggChicken,
                  coast: 3.00);
            }),
        itemDetailBody(
            image: imageEgg,
            title: eggDuck,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageEgg,
                  title: eggDuck,
                  coast: 3.00);
            }),
        itemDetailBody(
            image: imageEgg,
            title: eggGooseegg,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageEgg,
                  title: eggGooseegg,
                  coast: 34.93);
            }),
        itemDetailBody(
            image: imageEgg,
            title: eggOstrich,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageEgg,
                  title: eggOstrich,
                  coast: 50.74);
            }),
        itemDetailBody(
            image: imageEgg,
            title: eggQuail,
            onTap: () {
              Utils.instance.showBottomSheet(
                  context: context,
                  image: imageEgg,
                  title: eggQuail,
                  coast: 2.02);
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
