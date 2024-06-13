import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/add_item/add_item_state.dart';
import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import 'edit_item_cubit.dart';
import 'edit_item_state.dart';

class EditItemScreen extends StatefulWidget {
  final String name;
  const EditItemScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final EditItemCubit _editItemCubit = getIt.get<EditItemCubit>();
  TextEditingController _textEditingControllerTenMatHang =
      TextEditingController();
  TextEditingController _textEditingControllerGiaMatHang =
      TextEditingController();
  TextEditingController _textEditingControllerDonViTinh =
      TextEditingController();
  String? selectedValue;
  FoodEntity? entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(chinhSuaMatHang),
      ),
      body: SafeArea(
        child: BlocProvider<EditItemCubit>(
          create: (_) => _editItemCubit,
          child: BlocConsumer<EditItemCubit, EditItemState>(
            builder: (_, EditItemState state) {
              return itemBody();
            },
            listener: (_, EditItemState state) {
              handleListener(state);
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _editItemCubit.getDataFood(widget.name);
    selectedValue = entity?.loai;
  }

  Widget itemBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Utils.instance.sizeBoxHeight(16),
          itemDetailBody(
              hintText: entity?.ten,
              textEditingController: _textEditingControllerTenMatHang),
          Utils.instance.sizeBoxHeight(16),
          DropdownButton<String>(
            value: selectedValue,
            items: <String>[meat, fish, fruit, vegetable, egg, spices]
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
          ),
          Utils.instance.sizeBoxHeight(16),
          itemDetailBody(
              hintText: entity?.gia,
              textEditingController: _textEditingControllerGiaMatHang),
          Utils.instance.sizeBoxHeight(16),
          itemDetailBody(
              hintText: entity?.donVi,
              textEditingController: _textEditingControllerDonViTinh),
          Utils.instance.sizeBoxHeight(16),
          itemButton()
        ],
      ),
    );
  }

  Widget itemButton() {
    return GestureDetector(
      onTap: () {
        handleEditItem();
      },
      child: Container(
        height: 40,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey,
        ),
        child: Container(
            margin: EdgeInsets.only(left: 8),
            child: const Center(child: Text(chinhSuaDonDang))),
      ),
    );
  }

  Widget itemDetailBody(
      {String? hintText, TextEditingController? textEditingController}) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }

  void handleEditItem() {
    if (_textEditingControllerTenMatHang.text.isNotEmpty) {
      entity?.ten = _textEditingControllerTenMatHang.text;
    }
    if (_textEditingControllerGiaMatHang.text.isNotEmpty) {
      entity?.gia = _textEditingControllerGiaMatHang.text;
    }
    if (_textEditingControllerDonViTinh.text.isNotEmpty) {
      entity?.donVi = _textEditingControllerDonViTinh.text;
    }


    _editItemCubit.saveEditDataFood(foodEntity: entity);
  }


  void handleClickHome() {
    GoRouter.of(context).pushNamed(routerNameHome);
  }

  void handleListener(EditItemState state) {
    if (state is GetFood) {
      entity = state.entity;
    }
    if(state is SaveDataFood){
      Utils.instance.showToast('thanh cong');
      handleClickHome();
    }
  }
}
