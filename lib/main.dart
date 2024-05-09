import 'package:flutter/material.dart';
import 'package:flutter_sale_application/entity/user_adapter.dart';
import 'package:flutter_sale_application/home/sale_application_cubit.dart';
import 'package:flutter_sale_application/login/login_cubit.dart';
import 'package:flutter_sale_application/router/my_application.dart';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register/register_cubit.dart';

final GetIt getIt = GetIt.instance;
SharedPreferences? preferences;

void main() async {
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
      debugShowCheckedModeBanner: false,
      home: MyApplication(),
    );
  }
}
