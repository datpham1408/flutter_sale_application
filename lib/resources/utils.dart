import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Utils {
  static final Utils _instance = Utils._internal();

  static Utils get instance => _instance;

  Utils._internal();

  Widget sizeBoxHeight(double? height) {
    return SizedBox(
      height: height,
    );
  }

  Widget sizeBoxWidth(double? width) {
    return SizedBox(
      width: width,
    );
  }

  void showToast(String? content) {
    EasyLoading.showToast(content ?? '');
  }

}
