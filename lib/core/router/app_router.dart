import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth_/presentation/router/auth_routes.dart';
import '../../features/home/router/home_routes.dart';
import '../global/router/global_routes.dart';
import 'app_router_notifier.dart';
import 'app_router_redirect.dart';

enum AppRoute {
  login,
  home,
  disabled,
}

extension AppRoutePath on AppRoute {
  String get path => switch (this) {
        AppRoute.home => '/',
        AppRoute.login => '/login',
        AppRoute.disabled => '/disabled',
      };
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(appRouterNotifier);

  return GoRouter(
    refreshListenable: notifier,
    initialLocation: AppRoute.home.path,
    redirect: (context, state) => appRouterRedirect(state, notifier),
    routes: [
      ...homeRoutes,
      ...authRoutes,
      ...globalRoutes,
    ],
  );
});
