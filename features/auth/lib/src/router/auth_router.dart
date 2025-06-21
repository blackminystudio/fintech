// modules/shopping/lib/module_shopping.dart

import 'package:core/core.dart';

import 'auth_router.gr.dart';

@AutoRouterConfig()
class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(
          page: DisabledUserRoute.page,
          path: '/disabled',
          initial: true,
        ),
      ];
}
