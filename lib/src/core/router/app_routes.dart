import 'package:e_mart/src/core/router/routes_name.dart';
import 'package:e_mart/src/features/products/presentation/view/home_screen.dart';
import 'package:e_mart/src/features/shared/presentation/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final Provider<GoRouter> goRouterProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: "/",
        name: RoutesName.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: "/home",
        name: RoutesName.home,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
    ],
  );
});
