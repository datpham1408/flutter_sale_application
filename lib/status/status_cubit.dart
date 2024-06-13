import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/status/status_state.dart';
import 'package:hive/hive.dart';

import '../entity/cart_entity.dart';
import '../resources/hive_key.dart';

class StatusCubit extends Cubit<StatusState>{
  StatusCubit() : super(StatusState());

  Future<void> getMarketFood() async {
    final Box<MarketFoodEntity> box =
    await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);
    final List<MarketFoodEntity> listEntity = box.values.toList();

    // var total = listEntity
    //     .map((item) => item.thanhTien)
    //     .reduce((value, element) => value! + element!);
var total = 0.0;
    emit(GetBuyFoodState(entity: listEntity, total: total ?? 0.0));
  }
  Future<void> getCartFood() async {
    final Box<CartEntity> box =
    await Hive.openBox<CartEntity>(HiveKey.cart);
    final List<CartEntity> entity = box.values.toList();

    emit(GetMarketState(entity: entity));
  }
}