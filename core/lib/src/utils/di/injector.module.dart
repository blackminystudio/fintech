//@GeneratedMicroModule;CorePackageModule;package:core/src/utils/di/injector.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core/core.dart' as _i494;
import 'package:core/src/log/log.dart' as _i160;
import 'package:core/src/storages/local/secure_storage_impl.dart' as _i104;
import 'package:core/src/utils/device_info_util.dart' as _i676;
import 'package:core/src/utils/di/register_module.dart' as _i1072;
import 'package:core/src/utils/package_info_util.dart' as _i925;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:package_info_plus/package_info_plus.dart' as _i655;

class CorePackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final registerModule = _$RegisterModule();
    gh.factory<_i974.Logger>(() => registerModule.logger);
    await gh.factoryAsync<_i655.PackageInfo>(
      () => registerModule.packageInfo,
      preResolve: true,
    );
    gh.factory<_i833.DeviceInfoPlugin>(() => registerModule.deviceInfo);
    gh.factory<_i558.FlutterSecureStorage>(() => registerModule.secureStorage);
    gh.lazySingleton<_i160.Log>(() => _i160.Log());
    gh.factory<_i676.DeviceUtil>(
      () => _i676.DeviceUtil(gh<_i833.DeviceInfoPlugin>()),
    );
    gh.lazySingleton<_i494.LocalStorage>(
      () => _i104.SecureStorageImpl(gh<_i558.FlutterSecureStorage>()),
      instanceName: 'secure',
    );
    gh.factory<_i925.PackageUtil>(
      () => _i925.PackageUtil(gh<_i655.PackageInfo>()),
    );
  }
}

class _$RegisterModule extends _i1072.RegisterModule {}
