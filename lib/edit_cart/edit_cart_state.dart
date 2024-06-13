import 'package:flutter_sale_application/entity/cart_entity.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';

class EditCartState {}

class GetMarketFood extends EditCartState {
  final CartEntity entity;

  GetMarketFood({required this.entity});
}

class EditDetailMarketState extends EditCartState {}

class GetBuyFoodState extends EditCartState {
  final List<MarketFoodEntity> entity;
  final double total;

  GetBuyFoodState({required this.entity, required this.total});
}

class DeleteFood extends EditCartState{
  final MarketFoodEntity entity;

  DeleteFood({required this.entity});
}