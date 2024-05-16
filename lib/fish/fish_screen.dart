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
        itemDetailBody(
            image: imageFish,
            title: mackerel,
            onTap: () {
              Utils.instance.showBottomSheet(context:context,image:imageFish,title: mackerel,coast:134.00 );
            }),
        itemDetailBody(
            image: imageFish,
            title: herring,
            onTap: () {
              Utils.instance.showBottomSheet(context:context,image:imageFish,title: herring,coast:100.00 );
            }),
        itemDetailBody(
            image: imageFish,
            title: carp,
            onTap: () {
              Utils.instance.showBottomSheet(context:context,image:imageFish,title: carp,coast:210.93 );
            }),
        itemDetailBody(
            image: imageFish,
            title: salmon,
            onTap: () {
              Utils.instance.showBottomSheet(context:context,image:imageFish,title: salmon,coast:150.74 );
            }),
        itemDetailBody(
            image: imageFish,
            title: pilchard,
            onTap: () {
              Utils.instance.showBottomSheet(context:context,image:imageFish,title: pilchard,coast:90.22 );
            }),
        itemDetailBody(
            image: imageFish,
            title: tuna,
            onTap: () {
              Utils.instance.showBottomSheet(context:context,image:imageFish,title: tuna,coast:190.37 );
            }),
        itemDetailBody(
            image: imageFish,
            title: anchovy,
            onTap: () {
              Utils.instance.showBottomSheet(context:context,image:imageFish,title: anchovy,coast:89.65 );
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
