import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../pages/disabled_user_page.dart';

final globalRoutes = <GoRoute>[
  GoRoute(
    path: AppRoute.disabled.path,
    name: AppRoute.disabled.name,
    builder: (context, state) => const DisabledUserPage(),
  ),
];
