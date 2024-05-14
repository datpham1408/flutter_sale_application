import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/home/sale_application_cubit.dart';
import 'package:flutter_sale_application/home/sale_application_state.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

class SaleApplicationHomeScreen extends StatefulWidget {
  const SaleApplicationHomeScreen({super.key});

  @override
  State<SaleApplicationHomeScreen> createState() =>
      _SaleApplicationHomeScreenState();
}

class _SaleApplicationHomeScreenState extends State<SaleApplicationHomeScreen> {
  final SaleApplicationCubit _saleApplicationCubit =
      getIt.get<SaleApplicationCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider<SaleApplicationCubit>(
        create: (_) => _saleApplicationCubit,
        child: BlocConsumer<SaleApplicationCubit, SaleApplicationState>(
          listener: (_, SaleApplicationState state) {
            _handleListener(state);
          },
          builder: (_, SaleApplicationState state) {
            return itemBody();
          },
        ),
      ),
    ));
  }

  Widget itemBody() {
    return Column(
      children: [
        Expanded(flex: 8, child: itemGoods()),
      ],
    );
  }

  Widget itemGoods() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            itemDetailGoods(
                title: 'meat',
                image: 'assets/images/meat.png',
                onTap: () {
                  handleItemClickMeat();
                }),
            itemDetailGoods(
                title: 'fish',
                image: 'assets/images/fish.png',
                onTap: () {
                  handleItemClickFish();
                }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            itemDetailGoods(
                title: 'fruit',
                image: 'assets/images/fruit.png',
                onTap: () {
                  handleItemClickFruit();
                }),
            itemDetailGoods(
                title: 'vegetable',
                image: 'assets/images/vegetable.png',
                onTap: () {
                  handleItemClickVegetable();
                }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            itemDetailGoods(
                title: 'egg',
                image: 'assets/images/eggs.png',
                onTap: () {
                  handleItemClickEgg();
                }),
            itemDetailGoods(
                title: 'spices',
                image: 'assets/images/spices.png',
                onTap: () {
                  handleItemClickSpices();
                }),
          ],
        ),
      ],
    );
  }

  void handleItemClickMeat() {
    GoRouter.of(context).pushNamed(
      routerNameMeat,
    );
  }

  void handleItemClickFish() {
    GoRouter.of(context).pushNamed(
      routerNameFish,
    );
  }

  void handleItemClickFruit() {
    GoRouter.of(context).pushNamed(
      routerNameFruit,
    );
  }

  void handleItemClickVegetable() {
    GoRouter.of(context).pushNamed(
      routerNameVegetable,
    );
  }

  void handleItemClickEgg() {
    GoRouter.of(context).pushNamed(
      routerNameEgg,
    );
  }

  void handleItemClickSpices() {
    GoRouter.of(context).pushNamed(
      routerNameSpices,
    );
  }

  Widget itemDetailGoods({String? title, String? image, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.orange),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image ?? ''),
            Utils.instance.sizeBoxHeight(4),
            Text(title ?? ''),
          ],
        ),
      ),
    );
  }

  void _handleListener(SaleApplicationState state) {}
}
