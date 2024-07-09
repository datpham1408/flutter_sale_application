import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:flutter_sale_application/status/status_cubit.dart';
import 'package:flutter_sale_application/status/status_state.dart';
import 'package:go_router/go_router.dart';

import '../entity/cart_entity.dart';
import '../entity/market_food_entity.dart';
import '../main.dart';
import '../resources/utils.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final StatusCubit _statusCubit = getIt.get<StatusCubit>();
  List<MarketFoodEntity>? listFoodEntity;
  List<CartEntity>? cartEntity;
  double total = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider<StatusCubit>(
        create: (_) => _statusCubit,
        child: BlocConsumer<StatusCubit, StatusState>(
          listener: (_, StatusState state) {
            _handleListener(state);
          },
          builder: (_, StatusState state) {
            return itemBody();
          },
        ),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _statusCubit.getMarketFood();
    _statusCubit.getCartFood();
  }

  void _handleListener(StatusState state) {
    if (state is GetBuyFoodState) {
      listFoodEntity = state.entity;
      total = state.total;
    }
    if (state is GetMarketState) {
      cartEntity = state.entity;
    }
  }

  void handleClickEditCart() {
    GoRouter.of(context).pushNamed(routerNameEditCart);
  }

  Widget itemBody() {
    return ListView.builder(
      itemCount: cartEntity?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final CartEntity? entity = cartEntity?[index];
        return itemDetailBody(
          tenKhachHang: entity?.tenKhachHang,
          diaChi: entity?.diaChi,
        );
      },
    );
  }

  Widget itemDetailBody({String? tenKhachHang, String? diaChi}) {
    return GestureDetector(
      onTap: () {
        handleClickEditCart();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 100,
        decoration: BoxDecoration(color: Colors.grey.shade300),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(width: 50, child: const Icon(Icons.shopping_cart)),
                Utils.instance.sizeBoxWidth(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Số Lượng Sản Phẩm: ${listFoodEntity?.length}'),
                    Text('Người Nhận: $tenKhachHang'),
                    Text('Địa Chỉ: $diaChi'),
                    const Text('Ngày Đặt: 29/5/2024'),
                    const Text('Dự Kiến Giao: 1/6/2024'),
                    const Align(
                        alignment: Alignment.bottomRight,
                        child: Text(dangVanChuyen)),
                  ],
                ),
              ],
            ),
            Text('Tổng : $total'),
          ],
        ),
      ),
    );
  }
}
