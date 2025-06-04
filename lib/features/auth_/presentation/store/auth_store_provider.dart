import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state/auth_state.dart';
import 'state/auth_store.dart';

final authStoreProvider = StateNotifierProvider<AuthStore, AuthState>(
  AuthStore.new,
);
