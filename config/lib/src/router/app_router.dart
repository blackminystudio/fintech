import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:home/home.dart';

@AutoRouterConfig(replaceInRouteName: Routers.replaceInRouteName)
final class AppRouter extends RootStackRouter {
  AppRouter(this.ref) : super(navigatorKey: Routers.navigatorKey);

  final Ref ref;

  // @override
  // List<AutoRouteGuard> get guards => [AuthGuard(ref)];

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    ...AuthRouter().routes,
    ...HomeRouter().routes.withGuards([AuthGuard(ref)]),
  ];
}

extension AutoRouteListGuardX on List<AutoRoute> {
  /// Returns a new list where every route has exactly [guards] attached.
  List<AutoRoute> withGuards(List<AutoRouteGuard> guards) =>
      map((route) => route.copyWith(guards: guards)).toList(growable: false);
}
