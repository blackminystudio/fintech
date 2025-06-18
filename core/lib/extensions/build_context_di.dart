// core/lib/extensions/build_context_di.dart

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

extension BuildContextDI on BuildContext {
  /// Shortcut for `GetIt.instance.get<T>()`
  T get<T extends Object>() => GetIt.instance.get<T>();
}
