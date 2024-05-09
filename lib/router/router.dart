import 'package:flutter/material.dart';
import 'package:flutter_sale_application/home/sale_application_home_screen.dart';
import 'package:flutter_sale_application/login/login_screen.dart';
import 'package:flutter_sale_application/register/register_screen.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
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
      path: routerPathHome,
      name: routerNameHome,
      builder: (BuildContext context, GoRouterState state) {
        return const SaleApplicationHomeScreen();
      },
    ),
  ],
);
