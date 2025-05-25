import 'package:go_router/go_router.dart';

import '../../../features/auth/ui/pages/login_page.dart';
import '../../../features/home/ui/pages/home_page.dart';
import '../../features/onboarding/ui/pages/onboarding_page.dart';

enum AppRoute {
  splash,
  login,
  onboarding,
  home,
}

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: AppRoute.login.name,
      builder: (final context, final state) => const LoginPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: AppRoute.onboarding.name,
      builder: (final context, final state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/home',
      name: AppRoute.home.name,
      builder: (final context, final state) => const HomePage(),
    ),
  ],
);
