import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig(replaceInRouteName: Routers.replaceInRouteName)
final class AppRouter extends RootStackRouter {
  AppRouter() : super(navigatorKey: Routers.navigatorKey);

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    ...AuthRouter().routes,
  ];
}

abstract class Routers {
  static const String replaceInRouteName = 'Page|Screen,Route';
  static final navigatorKey = GlobalKey<NavigatorState>();
}
