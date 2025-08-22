import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core.dart';
import '../../log/filter/release_log_filter.dart';
import '../../log/printer/pretty_printer.dart';

@module
abstract class RegisterModule {
  DeviceInfoPlugin get deviceInfo => DeviceInfoPlugin();

  Logger get logger => Logger(
    filter: ReleaseLogFilter(
      excludedLevels: {
        // Add your excluded log levels here e.g: [Level.info]
        // Level.info
      },
    ),
    printer: SimplePrettyPrinter(),
  );
  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}

@module
abstract class ServiceModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
}
