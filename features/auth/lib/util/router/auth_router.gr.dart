// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth/presentation/ux/pages/disabled_user_page.dart' as _i1;
import 'package:auth/presentation/ux/pages/loading_page.dart' as _i2;
import 'package:auth/presentation/ux/pages/login_page.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i4;

/// generated route for
/// [_i1.DisabledUserPage]
class DisabledUserRoute extends _i4.PageRouteInfo<void> {
  const DisabledUserRoute({List<_i4.PageRouteInfo>? children})
      : super(DisabledUserRoute.name, initialChildren: children);

  static const String name = 'DisabledUserRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.DisabledUserPage();
    },
  );
}

/// generated route for
/// [_i2.LoadingPage]
class LoadingRoute extends _i4.PageRouteInfo<void> {
  const LoadingRoute({List<_i4.PageRouteInfo>? children})
      : super(LoadingRoute.name, initialChildren: children);

  static const String name = 'LoadingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoadingPage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute({List<_i4.PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}
