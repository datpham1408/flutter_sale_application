import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class CartEntity extends HiveObject {
  @HiveField(0)
  String? tenKhachHang;

  @HiveField(1)
  String? diaChi;

  @HiveField(2)
  String? hinhThucThanhToan;

  @HiveField(3)
  double? tongTien;

  @HiveField(4)
  String? idFood;

  @HiveField(5)
  String? id;

 @HiveField(6)
  int? soLuongSanPham;
  // @HiveField(6)
  // List<DetailMarketFoodEntity>? listFood;
}
