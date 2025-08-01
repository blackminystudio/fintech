import 'package:core/core.dart';

import '../../domain/repositories/{{name}}_repository.dart';
import '../services/{{name}}_service.dart';

@LazySingleton(as: {{name.pascalCase()}}Repository)
class {{name.pascalCase()}}RepositoryImpl extends {{name.pascalCase()}}Repository {
  {{name.pascalCase()}}RepositoryImpl(this.service);
  {{name.pascalCase()}}Service service;
}
