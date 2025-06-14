import 'package:get_it/get_it.dart';

import '../../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../../features/auth/data/services/auth_service_impl.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/auth/domain/use_cases/logout.dart';
import '../../../features/auth/domain/use_cases/sign_in_with_google.dart';

final injector = GetIt.instance;

// Future<void> initSingletons() async {
//   //Services
//   injector.registerLazySingleton<LocalDb>(() => InitDbImpl());
//   injector.registerLazySingleton<NetworkService>(() => DioNetworkService());
//   injector.registerLazySingleton<SharedPref>(() => SharedPrefImplementation());

//   //initiating db
//   await injector<LocalDb>().initDb();
// }

void injectServices() {
  // Auth
  injector.registerFactory<AuthServiceImpl>(AuthServiceImpl.new);
}

void injectRepositories() {
  // Auth
  injector.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authService: injector.get<AuthServiceImpl>()),
  );
}

void injectUseCases() {
  // Auth
  final authRepo = injector.get<AuthRepository>();
  injector
    ..registerFactory<Logout>(
      () => Logout(authRepository: authRepo),
    )
    ..registerFactory<SignInWithGoogle>(
      () => SignInWithGoogle(authRepository: authRepo),
    );
}
