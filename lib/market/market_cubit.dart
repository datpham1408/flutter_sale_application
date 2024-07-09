import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/cart_entity.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/market/market_state.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:hive/hive.dart';

import '../resources/hive_key.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit() : super(MarketState());

  Future<void> getMarketFood() async {
    final Box<MarketFoodEntity> box =
        await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);
    final List<MarketFoodEntity> listEntity = box.values.toList();
    List<String> listKeys =
        listEntity.map((MarketFoodEntity e) => e.id.toString()).toList();
    // List<DetailMarketFoodEntity> listDetail =
    // List<double> total = listEntity.map((MarketFoodEntity e) =>e. );

    // var total = listEntity
    //     .map((item) => item.thanhTien)
    //     .reduce((value, element) => value! + element!);

    emit(GetBuyFoodState(entity: listEntity, total: 0.0, id: listKeys.first));
  }

  void checkEmpty({
    String tenKhachHang = '',
    String diaChi = '',
    String phuongThucThanhToan = '',
    double tongTien = 0.0,
    String idFood = '',
    String id = '',
    int soLuongSanPham = 0,
    String trangThaiDonHang = ''
  }) {
    if (tenKhachHang.isEmpty) {
      emit(ErrorField(text: tenEmpty));
      return;
    }
    if (diaChi.isEmpty) {
      emit(ErrorField(text: diaChiEmpty));
      return;
    }
    if (phuongThucThanhToan.isEmpty) {
      emit(ErrorField(text: phuongThucThanhToanEmpty));
      return;
    }

    saveDataMarket(
      tenKhachHang: tenKhachHang,
      diaChi: diaChi,
      phuongThucThanhToan: phuongThucThanhToan,
      tongTien: tongTien,
      trangThaiDonHang: trangThaiDonHang
    );
  }

  Future<void> saveDataMarket(
      {String tenKhachHang = '',
      String diaChi = '',
      String phuongThucThanhToan = '',
      double tongTien = 0.0,
      String idFood = '',
      String id = '',
      int soLuongSanPham = 0,
      String trangThaiDonHang = ''}) async {
    final box = await Hive.openBox<CartEntity>(HiveKey.cart);

    final cart = CartEntity()
      ..tenKhachHang = tenKhachHang
      ..diaChi = diaChi
      ..hinhThucThanhToan = phuongThucThanhToan
      ..tongTien = tongTien
      ..idFood = idFood
      ..id = id
      ..soLuongSanPham = soLuongSanPham
      ..trangThaiDonHang = trangThaiDonHang;

    await box.add(cart);

    emit(
      SuccessMarketFood(
          tenKhachHang: tenKhachHang,
          diaChi: diaChi,
          phuongThucThanhToan: phuongThucThanhToan,
          tongTien: tongTien,
          id: id,
          idFood: idFood,
          soLuongSanPham: soLuongSanPham,
          trangThaiDonHang: trangThaiDonHang),
    );
  }

  Future<void> deleteFood(List<MarketFoodEntity> list) async {
    final Box<MarketFoodEntity> box =
        await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);
    List<String> listKey = list.map((e) => e.id.toString()).toList();
    box.deleteAll(listKey);

    emit(DeleteFood(entity: list));
  }
}
