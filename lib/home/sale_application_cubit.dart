import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/food_entity.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/home/sale_application_state.dart';
import 'package:flutter_sale_application/resources/hive_key.dart';
import 'package:hive/hive.dart';

class SaleApplicationCubit extends Cubit<SaleApplicationState> {
  SaleApplicationCubit() : super(SaleApplicationState());

  Future<void> getDataFood(String fieldLoai) async {
    final Box<FoodEntity> box = await Hive.openBox<FoodEntity>(HiveKey.food);
    final List<FoodEntity> listEntity = box.values.toList();

    final List<FoodEntity> listEntityLoai =
        listEntity.where((entity) => entity.loai == fieldLoai).toList();
    emit(FoodLoadedState(entity: listEntityLoai, loai: fieldLoai));
  }

  Future<void> getDataUser(String? email) async {
    final Box<UserEntity> box = await Hive.openBox<UserEntity>(HiveKey.user);
    final List<UserEntity> listEntity = box.values.toList();

    final UserEntity userEntity = listEntity.firstWhere((entity) => entity.email == email);

    emit(GetUser(entity: userEntity));
  }

  Future<void> getMarketFood() async {
    final Box<MarketFoodEntity> box = await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);
    final List<MarketFoodEntity> listEntity = box.values.toList();

    emit(MarketFoodState(entity: listEntity));
  }
  Future<void> deleteFood(List<MarketFoodEntity> list)async{
    final Box<MarketFoodEntity> box = await Hive.openBox<MarketFoodEntity>(HiveKey.marketFood);
   //get list id from list param
   List<String> listKeys =  list.map((MarketFoodEntity e) => e.id.toString()).toList();

    box.deleteAll(listKeys);

    emit(DeleteFoodState(entity: list));
  }
}
