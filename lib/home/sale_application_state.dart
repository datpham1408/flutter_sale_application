import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';

class SaleApplicationState {}

class FoodLoadedState extends SaleApplicationState {
  final List<FoodEntity> entity;
  final String loai;

  FoodLoadedState({required this.entity, required this.loai});
}
class GetUser extends SaleApplicationState {
  final UserEntity entity;

  GetUser({required this.entity});
}


class MarketFoodState extends SaleApplicationState {
  final List<MarketFoodEntity> entity;

  MarketFoodState({required this.entity});
}
class DeleteFoodState extends SaleApplicationState {
  final List<MarketFoodEntity> entity;

  DeleteFoodState({required this.entity});
}
