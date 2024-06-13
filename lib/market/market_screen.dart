import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/market/market_cubit.dart';
import 'package:flutter_sale_application/market/market_state.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final MarketCubit _marketCubit = getIt.get<MarketCubit>();
  List<MarketFoodEntity>? list;
  double total = 0.0;
  TextEditingController _textEditingControllerTenKhachHang =
      TextEditingController();
  TextEditingController _textEditingControllerDiaChi = TextEditingController();
  String? selectedValue;
  String idFood = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(datHang),
      ),
      body: SafeArea(
        child: BlocProvider<MarketCubit>(
          create: (_) => _marketCubit,
          child: BlocConsumer<MarketCubit, MarketState>(
            listener: (_, MarketState state) {
              _handleListener(state);
            },
            builder: (_, MarketState state) {
              return SingleChildScrollView(child: itemBody());
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _marketCubit.getMarketFood();
  }

  Widget itemBody() {
    return Column(
      children: [
        ListView.builder(
          itemCount: list?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final MarketFoodEntity? entity = list?[index];
            // return itemDetailBody(
            //     image: entity?.image,
            //     title: entity?.ten,
            //     soLuong: entity?.soLuong,
            //     thanhTien: entity?.thanhTien);
            return Container();
          },
        ),
        itemTextFlied(
            text: fullName,
            textEditingController: _textEditingControllerTenKhachHang),
        itemTextFlied(
            text: diaChi, textEditingController: _textEditingControllerDiaChi),
        itemPhuongThucThanhToan(),
        Text('thanh toan: ${total.toStringAsFixed(2)}'),
        itemButton()
      ],
    );
  }

  Widget itemPhuongThucThanhToan() {
    return Column(
      children: [
        const Text(phuongThucThanhToan),
        Utils.instance.sizeBoxHeight(4),
        DropdownButton<String>(
          value: selectedValue,
          items: <String>[the, tienMat, momo].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(
              () {
                selectedValue = newValue;
              },
            );
          },
        ),
      ],
    );
  }

  Widget itemTextFlied(
      {String text = '', TextEditingController? textEditingController}) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Utils.instance.sizeBoxHeight(4),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  Widget itemButton() {
    return GestureDetector(
      onTap: () {
        _marketCubit.checkEmpty(
            tenKhachHang: _textEditingControllerTenKhachHang.text,
            diaChi: _textEditingControllerDiaChi.text,
            phuongThucThanhToan: selectedValue ?? '',
            tongTien: total,soLuongSanPham: list?.length ??0,id: '1',idFood: idFood);
      },
      child: Container(
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey,
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

  void _handleListener(MarketState state) {
    if (state is GetBuyFoodState) {
      list = state.entity;
      total = state.total;
      idFood = state.id;
    }
    if (state is SuccessMarketFood) {
      Utils.instance.showToast(thanhCong);
      _marketCubit.deleteFood(list!);
      handleClickHome();
    }
    if (state is ErrorField) {
      Utils.instance.showToast(state.text);
    }
  }

  void handleClickHome() {
    GoRouter.of(context).pushNamed(routerNameHome);
  }
}
