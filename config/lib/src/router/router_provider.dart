// core/lib/src/router/router_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';

/// A singleton instance of your AppRouter.
/// Riverpod will only create it once, no matter how many rebuilds.
final routerProvider = Provider<AppRouter>(AppRouter.new);
