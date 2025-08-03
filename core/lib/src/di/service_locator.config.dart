// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auth/auth.dart' as _i662;
import 'package:core/core.dart' as _i494;
import 'package:core/src/di/register_module.dart' as _i256;
import 'package:core/src/log/log.dart' as _i160;
import 'package:core/src/storages/local/secure_storage_impl.dart' as _i104;
import 'package:core/src/utils/device_info_util.dart' as _i676;
import 'package:core/src/utils/package_info_util.dart' as _i925;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:home/home.dart' as _i1024;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:package_info_plus/package_info_plus.dart' as _i655;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
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
  await _i662.AuthPackageModule().init(gh);
  await _i1024.HomePackageModule().init(gh);
  return getIt;
}

class _$RegisterModule extends _i256.RegisterModule {}
