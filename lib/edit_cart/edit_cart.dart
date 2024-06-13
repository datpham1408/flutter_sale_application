import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/cart_entity.dart';
import 'package:go_router/go_router.dart';

import '../entity/market_food_entity.dart';
import '../main.dart';
import '../resources/string.dart';
import '../resources/utils.dart';
import '../router/route_constant.dart';
import 'edit_cart_cubit.dart';
import 'edit_cart_state.dart';

class EditCartScreen extends StatefulWidget {
  const EditCartScreen({Key? key}) : super(key: key);

  @override
  State<EditCartScreen> createState() => _EditCartScreenState();
}

class _EditCartScreenState extends State<EditCartScreen> {
  final EditCartCubit _editCartCubit = getIt.get<EditCartCubit>();
  List<MarketFoodEntity>? list;
  CartEntity? cartEntity;
  double total = 0.0;
  TextEditingController _textEditingControllerTenKhachHang =
      TextEditingController();
  TextEditingController _textEditingControllerDiaChi = TextEditingController();

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(chiTietDonHang),
        ),
        body: SafeArea(
          child: BlocProvider<EditCartCubit>(
            create: (_) => _editCartCubit,
            child: BlocConsumer<EditCartCubit, EditCartState>(
              listener: (_, EditCartState state) {
                _handleListener(state);
              },
              builder: (_, EditCartState state) {
                return itemBody();
              },
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _editCartCubit.getMarketFood();
    _editCartCubit.getProfileMarketFood();
    selectedValue = cartEntity?.hinhThucThanhToan;
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
            //     thanhTien: entity?.thanhTien,
            //     entity: entity);
          },
        ),
        itemTextFlied(
            text: fullName,
            textEditingController: _textEditingControllerTenKhachHang,
            hint: cartEntity?.tenKhachHang),
        itemTextFlied(
            text: diaChi,
            textEditingController: _textEditingControllerDiaChi,
            hint: cartEntity?.diaChi),
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
      {String text = '',
      TextEditingController? textEditingController,
      String? hint}) {
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
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: hint),
            ),
          )
        ],
      ),
    );
  }

  Widget itemButton() {
    return GestureDetector(
      onTap: () {
        handleEditCart();
      },
      child: Container(
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey,
          ),
          child: const Text(chinhSuaDonDang)),
    );
  }

  Widget itemDetailBody(
      {String? image,
      String? title,
      int? soLuong,
      double? thanhTien,
      MarketFoodEntity? entity}) {
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
            Row(
              children: [
                Text('tong :$thanhTien'),
                Utils.instance.sizeBoxWidth(4),
                GestureDetector(
                  onTap: () {
                    _editCartCubit.deleteFood(entity!);
                  },
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleEditCart() {
    if (_textEditingControllerTenKhachHang.text.isNotEmpty) {
      cartEntity?.tenKhachHang = _textEditingControllerTenKhachHang.text;
    }
    if (_textEditingControllerDiaChi.text.isNotEmpty) {
      cartEntity?.diaChi = _textEditingControllerDiaChi.text;
    }
    if (selectedValue != null) {
      cartEntity?.hinhThucThanhToan = selectedValue;
    }

    _editCartCubit.saveEditDataTask(cartEntity: cartEntity);
  }

  void _handleListener(EditCartState state) {
    if (state is GetBuyFoodState) {
      list = state.entity;
      total = state.total;
    }
    if (state is EditDetailMarketState) {
      Utils.instance.showToast(thanhCong);
      handleClickHome();
    }
    if (state is GetMarketFood) {
      cartEntity = state.entity;
    }
    if (state is DeleteFood) {
      _editCartCubit.getMarketFood();
    }
  }

  void handleClickHome() {
    GoRouter.of(context).pushNamed(routerNameHome);
  }
}
