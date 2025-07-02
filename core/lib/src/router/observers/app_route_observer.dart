import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import '../../../core.dart';

class AppRouteObserver extends AutoRouteObserver {
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    dev.log(
      'InitTabRoute: ${route.name}; from: ${previousRoute?.name}',
      name: 'AppRouteObserver',
    );
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    dev.log(
      'ChangeTabRoute: ${route.name}; from: ${previousRoute.name}',
      name: 'AppRouteObserver',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    dev.log(
      'Pop: ${route.settings.name}; from: ${previousRoute?.settings.name}',
      name: 'AppRouteObserver',
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    dev.log(
      'Push: ${route.settings.name}; from: ${previousRoute?.settings.name}',
      name: 'AppRouteObserver',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    dev.log(
      'Remove: ${route.settings.name}; from: ${previousRoute?.settings.name}',
      name: 'AppRouteObserver',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    dev.log(
      'Replace: ${newRoute?.settings.name}; from: ${oldRoute?.settings.name}',
      name: 'AppRouteObserver',
    );
  }
}
