import 'dart:async';

import 'package:go_router/go_router.dart';

import 'app_router.dart';
import 'app_router_notifier.dart';

FutureOr<String?> appRouterRedirect(
  GoRouterState state,
  AppRouterNotifier notifier,
) {
  final authState = notifier.status;
  final path = state.uri.path;
  final onLogin = path == AppRoute.login.path;
  final onDisabled = path == AppRoute.disabled.path;
  final onLoading = path == AppRoute.loading.path;

  switch (authState) {
    case AuthStatus.loading:
      if (!onLoading) return AppRoute.loading.path;
      return null;

    case AuthStatus.disabled:
      if (!onDisabled) return AppRoute.disabled.path;
      return null;

    case AuthStatus.unauthenticated:
      if (!onLogin) return AppRoute.login.path;
      return null;

    case AuthStatus.authenticated:
      if (onLogin || onLoading) return AppRoute.home.path;
      return null;
  }
}
