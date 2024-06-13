import 'package:flutter/material.dart';
import 'package:flutter_sale_application/buy_food/buy_food_screen.dart';
import 'package:flutter_sale_application/edit_cart/edit_cart.dart';
import 'package:flutter_sale_application/edit_item/edit_item_screen.dart';
import 'package:flutter_sale_application/food/detail_food.dart';

import 'package:flutter_sale_application/home_screen.dart';
import 'package:flutter_sale_application/login/login_screen.dart';
import 'package:flutter_sale_application/market/market_screen.dart';
import 'package:flutter_sale_application/register/register_screen.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';

import '../add_item/add_item_screen.dart';

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
      path: routerPathMarket,
      name: routerNameMarket,
      builder: (BuildContext context, GoRouterState state) {
        return const MarketScreen();
      },
    ),
    GoRoute(
      path: routerPathEditCart,
      name: routerNameEditCart,
      builder: (BuildContext context, GoRouterState state) {
        return const EditCartScreen();
      },
    ),
    GoRoute(
        path: routerPathAddItem,
        name: routerNameAddItem,
        builder: (BuildContext context, GoRouterState state) {
          return const AddItemScreen();
        }),
    GoRoute(
        path: routerPathBuyFood,
        name: routerNameBuyFood,
        builder: (BuildContext context, GoRouterState state) {
          return const BuyFoodScreen();
        }),
    GoRoute(
        path: routerPathFoodDetail,
        name: routerNameFoodDetail,
        builder: (BuildContext context, GoRouterState state) {
          final dataEntity = (state.extra as Map<String, dynamic>?);
          final entity = dataEntity?['entity'];
          final title = dataEntity?['title'];
          return DetailFoodScreen(
            entity: entity,
            title: title ?? '',
          );
        }),
    GoRoute(
      path: routerPathHome,
      name: routerNameHome,
      builder: (BuildContext context, GoRouterState state) {
        final userEntity = (state.extra as Map<String, dynamic>?)?['userEntity'];
        return HomeScreen(
            userEntity: userEntity,
            );
      },
    ),
    GoRoute(
      path: routerPathEditItem,
      name: routerNameEditItem,
      builder: (BuildContext context, GoRouterState state) {
        final name = (state.extra as Map<String, dynamic>?)?['name'];
        return EditItemScreen(
             name: name,
            );
      },
    ),
  ],
);
