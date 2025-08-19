import 'package:auth/util/di/injector.module.dart';
import 'package:core/core.dart';
import 'package:home/util/di/injector.module.dart';
import 'package:onboarding/onboarding.dart';

import 'dependencies.config.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
  externalPackageModulesAfter: [
    ExternalModule(OnboardingPackageModule),
    ExternalModule(AuthPackageModule),
    ExternalModule(HomePackageModule),
    ExternalModule(CorePackageModule),
  ],
)
Future<void> configureDependencies() async => $initGetIt(getIt);
