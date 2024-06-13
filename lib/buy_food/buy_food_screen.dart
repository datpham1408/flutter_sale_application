import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/buy_food/buy_food_cubit.dart';
import 'package:flutter_sale_application/buy_food/buy_food_state.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import '../resources/string.dart';

class BuyFoodScreen extends StatefulWidget {
  const BuyFoodScreen({Key? key}) : super(key: key);

  @override
  State<BuyFoodScreen> createState() => _BuyFoodScreenState();
}

class _BuyFoodScreenState extends State<BuyFoodScreen> {
  final BuyFoodCubit _saleApplicationCubit = getIt.get<BuyFoodCubit>();
  List<MarketFoodEntity>? list;
  double total = 0.0;
  double thanhToan = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(gioHangScreen),
        ),
        body: SafeArea(
          child: BlocProvider<BuyFoodCubit>(
            create: (_) => _saleApplicationCubit,
            child: BlocConsumer<BuyFoodCubit, BuyFoodState>(
              listener: (_, BuyFoodState state) {
                _handleListener(state);
              },
              builder: (_, BuyFoodState state) {
                return itemBody();
              },
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _saleApplicationCubit.getMarketFood();
  }

  void _handleListener(BuyFoodState state) {
    if (state is GetBuyFoodState) {
      list = state.entity;
      total = state.total;
    }
  }

  Widget itemBody() {
    return Column(
      children: [
        ListView.builder(
          itemCount: list?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final MarketFoodEntity? entity = list?[index];
            return Container();
            // return itemDetailBody(
            //     image: entity?.image,
            //     title: entity?.ten,
            //     soLuong: entity?.soLuong,
            //     thanhTien: entity?.thanhTien);
          },
        ),
        Text('thanh toan: ${total.toStringAsFixed(2)}'),
        itemButton()
      ],
    );
  }

  void handleClickMarket() {
    GoRouter.of(context).pushNamed(
        routerNameMarket
    );
  }

  Widget itemButton() {
    return GestureDetector(
      onTap: () {
        handleClickMarket();
      },
      child: Container(
          margin: EdgeInsets.only(top: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.lightBlueAccent,
          ),
          child: const Text(datHang)),
    );
  }

  Widget itemDetailBody(
      {String? image, String? title, int? soLuong, double? thanhTien}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(image ?? ''),
                Utils.instance.sizeBoxWidth(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title ?? ''),
                    Utils.instance.sizeBoxHeight(4),
                    Text('$soLuong kg'),
                  ],
                ),
              ],
            ),
            Text('tong :$thanhTien'),
          ],
        ),
      ),
    );
  }
}
