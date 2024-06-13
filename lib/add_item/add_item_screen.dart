import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/add_item/add_item_state.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import 'add_item_cubit.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final AddItemCubit _addItemCubit = getIt.get<AddItemCubit>();
  TextEditingController _textEditingControllerTenMatHang =
      TextEditingController();
  TextEditingController _textEditingControllerGiaMatHang =
      TextEditingController();
  TextEditingController _textEditingControllerDonViTinh =
      TextEditingController();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(themMatHang),
      ),
      body: SafeArea(
        child: BlocProvider<AddItemCubit>(
          create: (_) => _addItemCubit,
          child: BlocConsumer<AddItemCubit, AddItemState>(
            builder: (_, AddItemState state) {
              return itemBody();
            },
            listener: (_, AddItemState state) {
              handleListener(state);
            },
          ),
        ),
      ),
    );
  }

  Widget itemBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Text(themMatHang),
          Utils.instance.sizeBoxHeight(16),
          itemDetailBody(
              hintText: tenMatHang,
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
              hintText: giaMatHang,
              textEditingController: _textEditingControllerGiaMatHang),
          Utils.instance.sizeBoxHeight(16),
          itemDetailBody(
              hintText: donViTinh,
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
        _addItemCubit.checkEmpty(
            ten: _textEditingControllerTenMatHang.text,
            loai: selectedValue ?? '',
            gia: _textEditingControllerGiaMatHang.text,
            donVi: _textEditingControllerDonViTinh.text,
            id: '1');
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
            child: const Center(child: Text(addItem))),
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

  void handleClickHome() {
    GoRouter.of(context).pushNamed(routerNameHome);
  }

  void handleListener(AddItemState state) {
    if (state is AddError) {
      var errorText = state.text;
      Utils.instance.showToast(errorText);
      return;
    }
    if (state is SuccessTask) {
      Utils.instance.showToast('thanh cong');
      handleClickHome();
    }
  }
}
