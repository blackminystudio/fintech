import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../ui/pages/login_page.dart';

final authRoutes = <GoRoute>[
  GoRoute(
    path: AppRoute.login.path,
    name: AppRoute.login.name,
    builder: (context, state) => const LoginPage(),
  ),
];
