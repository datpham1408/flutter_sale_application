import 'package:hive/hive.dart';

import 'food_entity.dart';

@HiveType(typeId: 1)
class MarketFoodEntity extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<DetailMarketFoodEntity>? listFood;
}

class DetailMarketFoodEntity{
  FoodEntity? entity;
  int? soluong;

  DetailMarketFoodEntity({required this.entity,required this.soluong});
}
