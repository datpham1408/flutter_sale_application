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
        itemDetailBody(image: imageEgg, title: eggChicken),
        itemDetailBody(image: imageEgg, title: eggDuck),
        itemDetailBody(image: imageEgg, title: eggGooseegg),
        itemDetailBody(image: imageEgg, title: eggOstrich),
        itemDetailBody(image: imageEgg, title: eggQuail),

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
