import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sale_application/buy_food/buy_food_cubit.dart';
import 'package:flutter_sale_application/cart/cart_cubit.dart';
import 'package:flutter_sale_application/edit_cart/edit_cart_cubit.dart';
import 'package:flutter_sale_application/edit_item/edit_item_cubit.dart';
import 'package:flutter_sale_application/entity/cart_adapter.dart';
import 'package:flutter_sale_application/entity/food_adapter.dart';
import 'package:flutter_sale_application/entity/market_food_adapter.dart';
import 'package:flutter_sale_application/entity/user_adapter.dart';
import 'package:flutter_sale_application/food/detail_food_cubit.dart';
import 'package:flutter_sale_application/home/sale_application_cubit.dart';
import 'package:flutter_sale_application/login/login_cubit.dart';
import 'package:flutter_sale_application/market/market_cubit.dart';
import 'package:flutter_sale_application/profile/profile_cubit.dart';
import 'package:flutter_sale_application/router/my_application.dart';
import 'package:flutter_sale_application/status/status_cubit.dart';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_item/add_item_cubit.dart';
import 'message/chat_cubit.dart';
import 'message_group/chat_group_cubit.dart';
import 'register/register_cubit.dart';

const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyAOkHg7z5n1PvZeQBVyH_F57074z6nUX54',
  appId: '1:391240880443:android:5269d3229cb5c0bc78a71e',
  messagingSenderId: '391240880443',
  projectId: 'flutter-sale-application',
  databaseURL: '',
  storageBucket: 'flutter-sale-application.appspot.com',
);

final GetIt getIt = GetIt.instance;
SharedPreferences? preferences;
late final FirebaseApp app;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(options: android);
  // FirebaseFirestore.instance.collection('user').doc().snapshots();
  await initGetIt();
  await initCubit();
  await initHive();
  await initSharedPreferences();
  runApp(const Application());
}

Future<void> initGetIt() async {}

Future<void> initCubit() async {
  getIt.registerFactory<LoginCubit>(() => LoginCubit());
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit());
  getIt.registerFactory<SaleApplicationCubit>(() => SaleApplicationCubit());
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit());
  getIt.registerFactory<CartCubit>(() => CartCubit());
  getIt.registerFactory<FoodCubit>(() => FoodCubit());
  getIt.registerFactory<BuyFoodCubit>(() => BuyFoodCubit());
  getIt.registerFactory<MarketCubit>(() => MarketCubit());
  getIt.registerFactory<StatusCubit>(() => StatusCubit());
  getIt.registerFactory<EditCartCubit>(() => EditCartCubit());

  getIt.registerFactory<EditItemCubit>(() => EditItemCubit());
  getIt.registerFactory<AddItemCubit>(() => AddItemCubit());
  getIt.registerFactory<ChatCubit>(() => ChatCubit());
  getIt.registerFactory<ChatGroupCubit>(() => ChatGroupCubit());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FoodAdapter());
  Hive.registerAdapter(MarketFoodAdapter());
  Hive.registerAdapter(CartAdapter());
}

Future<void> initSharedPreferences() async {}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: const MyApplication(),
      builder: EasyLoading.init(),
    );
  }
}
