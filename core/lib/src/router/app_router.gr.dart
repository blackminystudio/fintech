// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:core/src/router/wrapper/empty_router_page.dart' as _i1;
import 'package:core/src/router/wrapper/test_page.dart' as _i2;

/// generated route for
/// [_i1.EmptyRouterPage]
class EmptyRouterRoute extends _i3.PageRouteInfo<void> {
  const EmptyRouterRoute({List<_i3.PageRouteInfo>? children})
      : super(EmptyRouterRoute.name, initialChildren: children);

  static const String name = 'EmptyRouterRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.EmptyRouterPage();
    },
  );
}

/// generated route for
/// [_i2.TestPage]
class TestRoute extends _i3.PageRouteInfo<void> {
  const TestRoute({List<_i3.PageRouteInfo>? children})
      : super(TestRoute.name, initialChildren: children);

  static const String name = 'TestRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.TestPage();
    },
  );
}
