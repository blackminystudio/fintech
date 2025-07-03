// modules/shopping/lib/module_shopping.dart

import 'package:core/core.dart';

import 'home_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: Routers.replaceInRouteName)
class HomeRouter extends RootStackRouter {
  HomeRouter() : super(navigatorKey: Routers.navigatorKey);
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/home'),
  ];
}
