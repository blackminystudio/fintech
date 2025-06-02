import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../ui/pages/home_page.dart';

final homeRoutes = <GoRoute>[
  GoRoute(
    path: AppRoute.home.path,
    name: AppRoute.home.name,
    builder: (context, state) => const HomePage(),
  ),
];
