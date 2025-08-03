import 'dart:async';

import 'package:auth/data/services/auth_service.dart';
import 'package:auth/domain/entities/auth_entity.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:auth/presentation/store/src/auth_state.dart';
import 'package:auth/presentation/store/src/auth_store.dart';
import 'package:core/core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockRef extends Mock implements Ref {}

class MockRouter extends Mock implements StackRouter {}

class MockResolver extends Mock implements NavigationResolver {}

class MockAuthRepository extends Mock implements AuthRepository {
  final _controller = StreamController<Either<AppException, AuthEntity?>>();
  @override
  Stream<Either<AppException, AuthEntity?>> watchAuth() => _controller.stream;
  void emit(Either<AppException, AuthEntity?> value) => _controller.add(value);
  void close() => _controller.close();
}

class MockGoogleSignIn implements GoogleSignIn {
  MockGoogleSignInAccount? _currentUser;
  bool _isCancelled = false;
  void setCancelled(bool val) => _isCancelled = val;
  @override
  GoogleSignInAccount? get currentUser => _currentUser;
  @override
  Future<GoogleSignInAccount?> signIn() async {
    _currentUser = MockGoogleSignInAccount();
    return _isCancelled ? null : _currentUser;
  }

  @override
  Future<GoogleSignInAccount?> signOut() async {
    _currentUser = null;
    return null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockStore extends AuthStore {
  MockStore(super.ref, {AuthState state = const AuthState()}) {
    this.state = state;
  }

  bool signInCalled = false;
  bool loggedOut = false;

  @override
  Future<void> signInWithGoogle() async {
    signInCalled = true;
    state = const AuthState(status: AuthStatus.authenticated);
  }

  @override
  Future<void> logout() {
    loggedOut = true;
    return super.logout();
  }

  void setStatus(AuthStatus status) {
    state = AuthState(status: status);
  }
}
