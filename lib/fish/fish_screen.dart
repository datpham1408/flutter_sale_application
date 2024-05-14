import 'package:flutter/material.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';

class FishScreen extends StatefulWidget {
  const FishScreen({super.key});

  @override
  State<FishScreen> createState() => _FishScreenState();
}

class _FishScreenState extends State<FishScreen> {
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
        itemDetailBody(image: imageFish, title: mackerel),
        itemDetailBody(image: imageFish, title: herring),
        itemDetailBody(image: imageFish, title: carp),
        itemDetailBody(image: imageFish, title: salmon),
        itemDetailBody(image: imageFish, title: pilchard),
        itemDetailBody(image: imageFish, title: tuna),
        itemDetailBody(image: imageFish, title: anchovy),
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
