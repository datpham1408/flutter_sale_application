import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/food/detail_food_cubit.dart';
import 'package:flutter_sale_application/food/detail_food_state.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';

class DetailFoodScreen extends StatefulWidget {
  final List<FoodEntity>? entity;
  final String title;
  final UserModel? userModel;

  const DetailFoodScreen(
      {super.key,
      required this.entity,
      required this.title,
      required this.userModel});

  @override
  State<DetailFoodScreen> createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  final FoodCubit _foodCubit = getIt.get<FoodCubit>();
  // String? ten;
   List<FoodEntity>? food;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: BlocProvider<FoodCubit>(
            create: (_) => _foodCubit,
            child: BlocConsumer<FoodCubit, FoodState>(
              listener: (_, FoodState state) {
                _handleListener(state);
              },
              builder: (_, FoodState state) {
                return itemBody();
              },
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _foodCubit.getDataFood(widget.title);
    // _foodCubit.getDataUser(widget.userEntity?.email);
  }

  String handleImage() {
    String image = '';

    switch (widget.title) {
      case meat:
        image = imageMeat;
        break;
      case fish:
        image = imageFish;
        break;
      case fruit:
        image = imageFruit;
        break;
      case vegetable:
        image = imageVegetable;
        break;
      case egg:
        image = imageEgg;
        break;
      default:
        image = imageSpices;
    }
    return image;
  }

  Widget itemBody() {

    return food?.isNotEmpty == true
        ? ListView.builder(
            itemCount: food?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final FoodEntity foodEntity = food![index];
              return itemDetailBody(
                title: foodEntity.ten,
                image: handleImage(),
                coast: double.tryParse(foodEntity.gia ?? ''),
              );
            },
          )
        : const Center(
            child: Text(
            data,
            style: TextStyle(fontSize: 48, color: Colors.black),
          ));
  }

  Widget itemDetailBody({String? image, String? title, double? coast}) {

   //  Key();
   //  Key();
   //
   //  UniqueKey();
   //  ValueKey("aa");
   // var key1= GlobalKey<FormState>();
   // //node
   // key1.currentContext
   //  var key2 = GlobalKey<StateError>();

    return GestureDetector(
      // key: Key(""),
      onTap: () {
        if (widget.userModel?.role == user) {
          showBottomSheet(
              context: context,
              title: title,
              coast: coast ?? 0.0,
              image: image);
        }
        if (widget.userModel?.role == store) {
          handleClickEditFood(title ?? '');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
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
                  Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.grey.withOpacity(0.4),
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Image.asset(image ?? '')),
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
                      Utils.instance.sizeBoxWidth(16),
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
                      Utils.instance.sizeBoxWidth(16),
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
                  Utils.instance.sizeBoxHeight(8),
                  Text('Thành tiền: $totalPrice đ'),
                  Utils.instance.sizeBoxHeight(8),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('thêm vào giỏ hàng'))),
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

  void handleClickHome() {
    GoRouter.of(context).pop();
  }

  Future<void> handleClickEditFood(String name) async {
    var result = await GoRouter.of(context)
        .pushNamed(routerNameEditItem, extra: {'name': name});

    if (result != null) {
      _foodCubit.getDataFood(widget.title);
    }
  }

  void _handleListener(FoodState state) {
    if (state is SaveFood) {
      Utils.instance.showToast(thanhCong);
      handleClickHome();
    }
    if(state is GetDataFood){
      food = state.entity;
    }
    // if (state is GetUser) {
    //   ten = state.entity.selected;
    // }
  }
}
