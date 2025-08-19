//@GeneratedMicroModule;OnboardingPackageModule;package:onboarding/util/di/injector.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;
import 'package:onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i1072;
import 'package:onboarding/data/services/onboarding_service.dart' as _i875;
import 'package:onboarding/data/services/onboarding_service_impl.dart' as _i426;
import 'package:onboarding/domain/repositories/onboarding_repository.dart'
    as _i933;

class OnboardingPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i875.OnboardingService>(
        () => _i426.OnboardingServiceImpl());
    gh.lazySingleton<_i933.OnboardingRepository>(
        () => _i1072.OnboardingRepositoryImpl(gh<_i875.OnboardingService>()));
  }
}
