//@GeneratedMicroModule;OnboardingPackageModule;package:onboarding/util/di/injector.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:core/core.dart' as _i494;
import 'package:injectable/injectable.dart' as _i526;
import 'package:onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i1072;
import 'package:onboarding/data/services/onboarding_service.dart' as _i875;
import 'package:onboarding/data/services/onboarding_service_impl.dart' as _i426;
import 'package:onboarding/domain/repositories/onboarding_repository.dart'
    as _i933;
import 'package:onboarding/domain/use_cases/fetch_data.dart' as _i619;
import 'package:onboarding/domain/use_cases/update_data.dart' as _i235;

class OnboardingPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i875.OnboardingService>(
      () => _i426.OnboardingServiceImpl(
        firebaseFirestore: gh<_i494.FirebaseFirestore>(),
        firebaseAuth: gh<_i494.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i933.OnboardingRepository>(
      () => _i1072.OnboardingRepositoryImpl(gh<_i875.OnboardingService>()),
    );
    gh.factory<_i235.UpdateData>(
      () => _i235.UpdateData(gh<_i933.OnboardingRepository>()),
    );
    gh.factory<_i619.FetchData>(
      () => _i619.FetchData(gh<_i933.OnboardingRepository>()),
    );
  }
}
