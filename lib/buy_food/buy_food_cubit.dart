

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/buy_food/buy_food_state.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/resources/hive_key.dart';
import 'package:hive/hive.dart';

class BuyFoodCubit extends Cubit<BuyFoodState> {
  BuyFoodCubit() : super(BuyFoodState());

  Future<void> getMarketFood() async {
    final Box<MarketFoodEntity> box =
        await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);
    final List<MarketFoodEntity> listEntity = box.values.toList();

    // var total = listEntity
    //     .map((item) => item.thanhTien)
    //     .reduce((value, element) => value! + element!);

    emit(GetBuyFoodState(entity: listEntity, total:  0.0));
  }

}
