import 'package:core/core.dart';

import '{{name}}_state.dart';

class {{name.pascalCase()}}Store extends StateNotifier<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Store(this.ref) : super(const {{name.pascalCase()}}State());
  final Ref ref;
}
