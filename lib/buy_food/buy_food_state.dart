import 'package:flutter_sale_application/entity/market_food_entity.dart';

class BuyFoodState{}

class GetBuyFoodState extends BuyFoodState{
  final List<MarketFoodEntity> entity;
  final double total;

  GetBuyFoodState({required this.entity,required this.total});
}
class DeleteFood extends BuyFoodState{
  final List<MarketFoodEntity> entity;

  DeleteFood({required this.entity});
}