import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth.dart';
import '../../../presentation/store/src/auth_state.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.ref);
  final Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authStatus = ref.read(authStoreProvider).status;

    switch (authStatus) {
      case AuthStatus.authenticated:
        resolver.next();
        break;
      case AuthStatus.unauthenticated:
        router.replace(const LoginRoute());
        break;
      case AuthStatus.disabled:
        router.replace(const DisabledUserRoute());
        break;
      default:
        router.replace(const LoadingRoute());
    }
  }
}
