import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sale_application/cart/cart_cubit.dart';
import 'package:flutter_sale_application/entity/user_adapter.dart';
import 'package:flutter_sale_application/home/sale_application_cubit.dart';
import 'package:flutter_sale_application/login/login_cubit.dart';
import 'package:flutter_sale_application/profile/profile_cubit.dart';
import 'package:flutter_sale_application/router/my_application.dart';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register/register_cubit.dart';

const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyAOkHg7z5n1PvZeQBVyH_F57074z6nUX54',
  appId: '1:391240880443:android:5269d3229cb5c0bc78a71e',
  messagingSenderId: '391240880443',
  projectId: 'flutter-sale-application',
  databaseURL:  '',
  storageBucket: 'flutter-sale-application.appspot.com',
);


final GetIt getIt = GetIt.instance;
SharedPreferences? preferences;
late final FirebaseApp app;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: android
  ) ;
  await initGetIt();
  await initCubit();
  await initHive();
  await initSharedPreferences();
  runApp(const Application());
}

Future<void> initGetIt() async {}

Future<void> initCubit() async {
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());
  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  getIt.registerLazySingleton<SaleApplicationCubit>(() => SaleApplicationCubit());
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
  getIt.registerLazySingleton<CartCubit>(() => CartCubit());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
}

Future<void> initSharedPreferences() async {
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: MyApplication(),
    );
  }
}
