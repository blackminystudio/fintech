import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../util/router/auth_router.gr.dart';
import '../../store/auth_store_provider.dart';
import '../../store/src/auth_state.dart';

@RoutePage()
class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authStoreProvider, (prev, next) {
      switch (next.status) {
        case AuthStatus.authenticated:
          context.router.replacePath('/home');
          break;
        case AuthStatus.unauthenticated:
          context.router.replace(const LoginRoute());
          break;
        case AuthStatus.disabled:
          context.router.replace(const DisabledUserRoute());
          break;
        case AuthStatus.loading:
          break;
      }
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
