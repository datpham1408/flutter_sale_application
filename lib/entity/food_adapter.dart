
import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:hive/hive.dart';

class FoodAdapter extends TypeAdapter<FoodEntity> {
  @override
  final int typeId = 1;

  @override
  FoodEntity read(BinaryReader reader) {
    return FoodEntity()
      ..ten = reader.readString()
      ..loai = reader.readString()
      ..gia = reader.readString()
      ..donVi = reader.readString()
      ..id = reader.readString();

  }

  @override
  void write(BinaryWriter writer, FoodEntity food) {

    writer.writeString(food.ten ?? '');
    writer.writeString(food.loai ?? '');
    writer.writeString((food.gia ?? ''));
    writer.writeString(food.donVi ?? '');
    writer.writeString(food.id ?? '');

  }
}
