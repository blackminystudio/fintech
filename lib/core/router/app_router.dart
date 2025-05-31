import 'package:go_router/go_router.dart';

import '../../../features/home/ui/pages/home_page.dart';

enum AppRoute {
  splash,
  login,
  onboarding,
  home,
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
