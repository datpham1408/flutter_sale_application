import 'package:flutter/material.dart';
import 'package:flutter_sale_application/egg/egg_screen.dart';
import 'package:flutter_sale_application/fish/fish_screen.dart';
import 'package:flutter_sale_application/fruit/fruit_screen.dart';
import 'package:flutter_sale_application/meat/meat_screen.dart';
import 'package:flutter_sale_application/home_screen.dart';
import 'package:flutter_sale_application/login/login_screen.dart';
import 'package:flutter_sale_application/register/register_screen.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:flutter_sale_application/spices/spices_screen.dart';
import 'package:flutter_sale_application/vegestable/vegestable_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerMyApp = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: routerPathRegister,
      name: routerNameRegister,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
    GoRoute(
      path: routerPathLogin,
      name: routerNameLogin,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: routerPathMeat,
      name: routerNameMeat,
      builder: (BuildContext context, GoRouterState state) {
        return const MeatScreen();
      },
    ),
    GoRoute(
      path: routerPathFish,
      name: routerNameFish,
      builder: (BuildContext context, GoRouterState state) {
        return const FishScreen();
      },
    ),
    GoRoute(
      path: routerPathFruit,
      name: routerNameFruit,
      builder: (BuildContext context, GoRouterState state) {
        return const FruitScreen();
      },
    ),
    GoRoute(
      path: routerPathEgg,
      name: routerNameEgg,
      builder: (BuildContext context, GoRouterState state) {
        return const EggScreen();
      },
    ),
    GoRoute(
      path: routerPathVegetable,
      name: routerNameVegetable,
      builder: (BuildContext context, GoRouterState state) {
        return const VegetableScreen();
      },
    ),
    GoRoute(
      path: routerPathSpices,
      name: routerNameSpices,
      builder: (BuildContext context, GoRouterState state) {
        return const SpicesScreen();
      },
    ),
    GoRoute(
      path: routerPathHome,
      name: routerNameHome,
      builder: (BuildContext context, GoRouterState state) {
        final user = (state.extra as Map<String, dynamic>?)?['user'];
        return HomeScreen(
          user: user,
        );
      },
    ),
  ],
);
