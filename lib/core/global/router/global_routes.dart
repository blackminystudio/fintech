import 'package:go_router/go_router.dart';

import '../../router/app_router.dart';
import '../pages/disabled_user_page.dart';
import '../pages/loading_page.dart';

final globalRoutes = <GoRoute>[
  GoRoute(
    path: AppRoute.disabled.path,
    name: AppRoute.disabled.name,
    builder: (context, state) => const DisabledUserPage(),
  ),
  GoRoute(
    path: AppRoute.loading.path,
    name: AppRoute.loading.name,
    builder: (context, state) => const LoadingPage(),
  ),
];
