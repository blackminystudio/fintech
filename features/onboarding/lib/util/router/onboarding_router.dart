// coverage:ignore-file

import 'package:core/core.dart';

import 'onboarding_router.gr.dart';

@AutoRouterConfig()
class OnboardingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page, path: '/onboarding'),
  ];
}
