import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';

import '../entity/user_entity.dart';

class FoodState {}

class SaveFood extends FoodState {
  final String id;
  final List<DetailMarketFoodEntity> listEntity;

  SaveFood({required this.id, required this.listEntity});
}

class GetDataFood extends FoodState{
  final List<FoodEntity> entity;
  // final List<DetailMarketFoodEntity> entity;
  // final int soLuong;

  GetDataFood({required this.entity});
}

// class GetUser extends FoodState {
//   final UserEntity entity;
//
//   GetUser({required this.entity});
// }
