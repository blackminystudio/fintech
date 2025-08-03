import 'package:auth/auth.dart';
import 'package:home/home.dart';

import '../../core.dart';
import 'service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
  externalPackageModulesAfter: [
    ExternalModule(AuthPackageModule),
    ExternalModule(HomePackageModule),
  ],
)
Future<void> configureDependencies() async => $initGetIt(getIt);
