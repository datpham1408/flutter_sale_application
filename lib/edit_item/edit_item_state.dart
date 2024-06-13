import 'package:flutter_sale_application/entity/food_entity.dart';

class EditItemState {}

class GetFood extends EditItemState {
  final FoodEntity entity;

  GetFood({required this.entity});
}
class SaveDataFood extends EditItemState {
}
