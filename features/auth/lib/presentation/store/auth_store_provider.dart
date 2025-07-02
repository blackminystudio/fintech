import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/auth_state.dart';
import 'src/auth_store.dart';

final authStoreProvider =
    StateNotifierProvider<AuthStore, AuthState>(AuthStore.new);
