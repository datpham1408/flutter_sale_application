import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/resources/hive_key.dart';
import 'package:hive/hive.dart';
import 'edit_item_state.dart';

class EditItemCubit extends Cubit<EditItemState> {
  EditItemCubit() : super(EditItemState());

  Future<void> saveEditDataFood({FoodEntity? foodEntity}) async {
    //get list type cua entity
    final box = await Hive.openBox<FoodEntity>(HiveKey.food) ;
    final List<FoodEntity> list =box.values.toList();
    var a =0;

    await foodEntity?.save();

    //get
    final box1 = await Hive.openBox<FoodEntity>(HiveKey.food);
    final List<FoodEntity>list1 = box1.values.toList();
    var b = 0;

    emit(SaveDataFood());
  }

  Future<void> getDataFood(String title) async {
    final box = await Hive.openBox<FoodEntity>(HiveKey.food);
    final List<FoodEntity> list = box.values.toList();

    final FoodEntity entity = list.firstWhere((FoodEntity e) => e.ten == title);
    emit(GetFood(entity: entity));
  }
}
