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
        itemDetailBody(image:imageSalt , title: salt),
        itemDetailBody(image:imageSauce , title: sauce),
        itemDetailBody(image:imageSoySauce, title: soySauce),
        itemDetailBody(image:imageSugar , title: sugar),
        itemDetailBody(image:imageMSG , title: msg),
        itemDetailBody(image:imageCondiment , title: condiment),
        itemDetailBody(image:imagePepper , title: pepper),

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
