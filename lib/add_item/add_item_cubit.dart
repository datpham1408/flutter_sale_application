import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/add_item/add_item_state.dart';
import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/resources/hive_key.dart';
import 'package:hive/hive.dart';

import '../resources/string.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemState());

  void checkEmpty({
    String ten = '',
    String loai = '',
    String gia = '',
    String donVi = '',
    String id = '',
  }) {
    String errorText = "";
    if (ten.isEmpty) {
      errorText = tenEmpty;
    }
    if (loai.isEmpty) {
      errorText = loaiEmpty;
    }
    if (gia.isEmpty) {
      emit(AddError(text: giaEmpty));
      return;
    }
    if (donVi.isEmpty) {
      emit(AddError(text: donViEmpty));
      return;
    }

    if (errorText.isNotEmpty) {
      emit(AddError(text: errorText));
      return;
    }

    saveDataTask(ten: ten, loai: loai, gia: gia, donVi: donVi,id: id);
  }

  Future<void> saveDataTask({
    String ten = '',
    String loai = '',
    String gia = '',
    String donVi = '',
    String id = ''
  }) async {
    final box = await Hive.openBox<FoodEntity>(HiveKey.food);

    final food = FoodEntity()
      ..ten = ten
      ..loai = loai
      ..gia = gia
      ..donVi = donVi
      ..id = id;

    await box.add(food);

    emit(
      SuccessTask(
        ten: ten,
        loai: loai,
        gia: gia,
        donVi: donVi,
        id: id
      ),
    );
  }
}
