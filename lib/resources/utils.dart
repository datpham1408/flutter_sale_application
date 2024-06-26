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

  // void showBottomSheet(
  //     {required BuildContext context,
  //     String? image,
  //     String? title,
  //     double? coast}) {
  //   int count = 1;
  //
  //   showModalBottomSheet(
  //     isDismissible: true,
  //     context: context,
  //     builder: (BuildContext buildContext) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           void increment() {
  //             setState(() {
  //               count++;
  //             });
  //           }
  //
  //           void decrement() {
  //             setState(() {
  //               if (count > 1) {
  //                 count--;
  //               }
  //             });
  //           }
  //
  //           double totalPrice = count * (coast ?? 0.0);
  //
  //           return FractionallySizedBox(
  //             heightFactor: 0.5,
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Image.asset(image ?? ''),
  //                     Utils.instance.sizeBoxWidth(20),
  //                     Column(
  //                       children: [
  //                         Text(title ?? ''),
  //                         Utils.instance.sizeBoxHeight(4),
  //                         Text('$coast đ'),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //                 Utils.instance.sizeBoxHeight(16),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     GestureDetector(
  //                       onTap: decrement,
  //                       child: Container(
  //                         height: 30,
  //                         width: 30,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(360),
  //                           color: Colors.grey,
  //                         ),
  //                         child: const Center(
  //                           child: Text(
  //                             '-',
  //                             style: TextStyle(fontSize: 20),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     sizeBoxWidth(16),
  //                     Container(
  //                       height: 30,
  //                       width: 80,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(360),
  //                         color: Colors.grey,
  //                       ),
  //                       child: Center(
  //                         child: TextField(
  //                           decoration: InputDecoration(
  //                             hintText: '1',
  //                             border: InputBorder.none
  //                           ),
  //
  //                           onChanged: (value) {
  //                             setState(() {
  //                               count = int.tryParse(value) ?? 1;
  //                             });
  //                           },
  //                           style: const TextStyle(fontSize: 20),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ),
  //                     sizeBoxWidth(16),
  //                     GestureDetector(
  //                       onTap: increment,
  //                       child: Container(
  //                         height: 30,
  //                         width: 30,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(360),
  //                           color: Colors.grey,
  //                         ),
  //                         child: const Center(
  //                           child: Text(
  //                             '+',
  //                             style: TextStyle(fontSize: 20),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Utils.instance.sizeBoxHeight(16),
  //                 Text('thành tiền :$totalPrice '),
  //                 Utils.instance.sizeBoxHeight(16),
  //                 GestureDetector(
  //                   onTap: () {},
  //                   child: Container(
  //                     height: 40,
  //                     width: 80,
  //                     decoration:
  //                         BoxDecoration(color: Colors.grey.withOpacity(0.5)),
  //                     child: const Center(child: Text('thêm vào giỏ hàng')),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void showBottomSheet({
    required BuildContext context,
    String? image,
    String? title,
    required double coast,
  }) {
    int currentCount = 1;
    final double initialCoast = coast;

    showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (BuildContext buildContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void increment() {
              setState(() {
                currentCount++;
              });
            }

            void decrement() {
              setState(() {
                if (currentCount > 1) {
                  currentCount--;
                }
              });
            }

            double totalPrice = currentCount * initialCoast;

            return FractionallySizedBox(
              heightFactor: 0.5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(image ?? ''),
                      Utils.instance.sizeBoxWidth(20),
                      Column(
                        children: [
                          Text(title ?? ''),
                          Utils.instance.sizeBoxHeight(4),
                          Text('$coast đ'),
                        ],
                      )
                    ],
                  ),
                  Utils.instance.sizeBoxHeight(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: decrement,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: Colors.grey,
                          ),
                          child: const Center(
                            child: Text(
                              '-',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      sizeBoxWidth(16),
                      Flexible(
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: Colors.grey,
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '$currentCount',
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    currentCount = int.tryParse(value) ?? 1;
                                  });
                                },
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      sizeBoxWidth(16),
                      GestureDetector(
                        onTap: increment,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            color: Colors.grey,
                          ),
                          child: const Center(
                            child: Text(
                              '+',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Utils.instance.sizeBoxHeight(16),
                  Text('Thành tiền: $totalPrice đ'),
                  Utils.instance.sizeBoxHeight(16),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                      child: const Center(child: Text('thêm vào giỏ hàng')),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
