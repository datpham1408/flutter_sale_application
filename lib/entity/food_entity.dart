import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class FoodEntity extends HiveObject {
  @HiveField(0)
  String? ten;

  @HiveField(1)
  String? loai;

  @HiveField(2)
  String? gia;

  @HiveField(3)
  String? donVi;

  @HiveField(4)
  String? id;

}
