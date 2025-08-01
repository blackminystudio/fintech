import 'package:core/core.dart';

import '../../domain/repositories/{{name}}_repository.dart';
import 'src/{{name}}_state.dart';
import 'src/{{name}}_store.dart';

final {{name}}RepoProvider = Provider<{{name.pascalCase()}}Repository>(
  (ref) => getIt<{{name.pascalCase()}}Repository>(),
);

final {{name}}StoreProvider = StateNotifierProvider<{{name.pascalCase()}}Store, {{name.pascalCase()}}State>(
  {{name.pascalCase()}}Store.new,
);
