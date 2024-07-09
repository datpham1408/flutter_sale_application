import 'package:flutter_sale_application/entity/market_food_entity.dart';

class MarketState {}

class SuccessMarketFood extends MarketState {
  final String tenKhachHang;
  final String diaChi;
  final String phuongThucThanhToan;
  final String idFood;
  final String id;
  final double tongTien;
  final int soLuongSanPham;
  final String trangThaiDonHang;

  SuccessMarketFood({
    required this.tenKhachHang,
    required this.diaChi,
    required this.phuongThucThanhToan,
    required this.tongTien,
    required this.id,
    required this.soLuongSanPham,
    required this.idFood,
    required this.trangThaiDonHang,
  });
}

class ErrorField extends MarketState {
  final String text;

  ErrorField({required this.text});
}

class GetBuyFoodState extends MarketState {
  final List<MarketFoodEntity> entity;
  final double total;
  final String id;

  GetBuyFoodState({required this.entity, required this.total,required this.id});
}

class DeleteFood extends MarketState {
  final List<MarketFoodEntity> entity;

  DeleteFood({required this.entity});
}
