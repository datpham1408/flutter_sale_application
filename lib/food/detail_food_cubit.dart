import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/food/detail_food_state.dart';
import 'package:hive/hive.dart';

import '../entity/user_entity.dart';
import '../resources/hive_key.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodState());

  Future<void> saveMarketFood(
      {String id = '', List<DetailMarketFoodEntity>? list}) async {
    final box = await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);

    final food = MarketFoodEntity()
      ..id = id
      ..listFood = list;

    await box.put(food.id, food);

    emit(
      SaveFood(id: id, listEntity: list!),
    );
  }

  Future<void> getDataFood(String loai) async {
    final box = await Hive.openBox<FoodEntity>(HiveKey.food);
    final List<FoodEntity> entity = box.values.toList();
    final List<FoodEntity> loaiEntity = entity.where((element) => element.loai ==loai).toList();

    emit(GetDataFood(entity: loaiEntity));
  }

  // Future<void> getDataUser(String? email) async {
  //   final Box<UserEntity> box = await Hive.openBox<UserEntity>(HiveKey.user);
  //   final List<UserEntity> listEntity = box.values.toList();
  //
  //   final entity = listEntity.firstWhere((UserEntity element) => element.email == email);
  //
  //
  //   emit(GetUser(entity: entity));
  // }

}
