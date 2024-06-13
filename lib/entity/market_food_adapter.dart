import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:hive/hive.dart';

class MarketFoodAdapter extends TypeAdapter<MarketFoodEntity> {
  @override
  final int typeId = 2;

  @override
  MarketFoodEntity read(BinaryReader reader) {
    List<DetailMarketFoodEntity>? listTemp;
    reader.readList().map((e) {
      return e as DetailMarketFoodEntity;
    }).toList();

    return MarketFoodEntity()
      ..id = reader.readString()
      ..listFood = listTemp;
  }

  @override
  void write(BinaryWriter writer, MarketFoodEntity food) {
    writer.writeString(food.id ?? '');
    writer.writeList([food.listFood]);
  }
}
