//@GeneratedMicroModule;AuthPackageModule;package:auth/util/di/injector.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/data/repositories/auth_repository_impl.dart' as _i288;
import 'package:auth/data/services/auth_service.dart' as _i681;
import 'package:auth/data/services/auth_service_impl.dart' as _i295;
import 'package:auth/domain/repositories/auth_repository.dart' as _i698;
import 'package:auth/domain/use_cases/get_loggedin_user.dart' as _i775;
import 'package:auth/domain/use_cases/logout.dart' as _i477;
import 'package:auth/domain/use_cases/sign_in_with_google.dart' as _i154;
import 'package:auth/util/di/service_module.dart' as _i34;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

class AuthPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    final serviceModule = _$ServiceModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => serviceModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => serviceModule.googleSignIn);
    gh.lazySingleton<_i681.AuthService>(
      () => _i295.AuthServiceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i698.AuthRepository>(
      () => _i288.AuthRepositoryImpl(gh<_i681.AuthService>()),
    );
    gh.factory<_i154.SignInWithGoogle>(
      () => _i154.SignInWithGoogle(gh<_i698.AuthRepository>()),
    );
    gh.factory<_i477.Logout>(() => _i477.Logout(gh<_i698.AuthRepository>()));
    gh.factory<_i775.GetLoggedInUser>(
      () => _i775.GetLoggedInUser(gh<_i698.AuthRepository>()),
    );
  }
}

class _$ServiceModule extends _i34.ServiceModule {}
