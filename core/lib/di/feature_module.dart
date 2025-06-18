// core/lib/di/feature_module.dart

import 'package:get_it/get_it.dart';

abstract class FeatureModule {
  void registerServices(GetIt getIt);
}
