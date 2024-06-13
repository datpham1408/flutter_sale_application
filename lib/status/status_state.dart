import '../entity/cart_entity.dart';
import '../entity/market_food_entity.dart';

class StatusState{}

class GetBuyFoodState extends StatusState{
  final List<MarketFoodEntity> entity;
  final double total;

  GetBuyFoodState({required this.entity,required this.total});
}
class GetMarketState extends StatusState{
  final List<CartEntity> entity;


  GetMarketState({required this.entity});
}