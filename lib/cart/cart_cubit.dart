import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());
}
