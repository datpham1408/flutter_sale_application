import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/edit_cart/edit_cart_state.dart';
import 'package:hive/hive.dart';

import '../entity/cart_entity.dart';
import '../entity/market_food_entity.dart';
import '../resources/hive_key.dart';

class EditCartCubit extends Cubit<EditCartState> {
  EditCartCubit() : super(EditCartState());

  Future<void> getMarketFood() async {
    final Box<MarketFoodEntity> box =
        await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);
    final List<MarketFoodEntity> listEntity = box.values.toList();

    // var total = listEntity
    //     .map((item) => item.thanhTien)
    //     .reduce((value, element) => value! + element!);

    emit(GetBuyFoodState(entity: listEntity, total:  0.0));
  }

  Future<void> getProfileMarketFood() async {
    final Box<CartEntity> box = await Hive.openBox<CartEntity>(HiveKey.cart);
    final CartEntity listEntity = box.values.first;

    emit(GetMarketFood(entity: listEntity));
  }

  Future<void> saveEditDataTask({CartEntity? cartEntity}) async {
    cartEntity?.save();

    emit(EditDetailMarketState());
  }

  Future<void> deleteFood(MarketFoodEntity entity) async {
    final Box<MarketFoodEntity> box =
        await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);
    box.delete(entity.key);
    emit(DeleteFood(entity: entity));
  }
}
