import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core/src/di/service_locator.config.dart';
import 'package:home/home.dart';

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
