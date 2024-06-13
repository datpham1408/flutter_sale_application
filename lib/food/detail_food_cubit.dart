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

  Future<void> getDataFood() async {
    final box = await Hive.openBox<FoodEntity>(HiveKey.food);
    final List<FoodEntity> entity = box.values.toList();

    emit(GetDataFood(entity: entity));
  }

  Future<void> getDataUser() async {
    final Box<UserEntity> box = await Hive.openBox<UserEntity>(HiveKey.user);
    final UserEntity listEntity = box.values.first;


    emit(GetUser(entity: listEntity));
  }

}
