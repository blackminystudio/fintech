import 'package:core/core.dart';
import '{{name}}_service.dart';

@LazySingleton(as: {{name.pascalCase()}}Service)
class {{name.pascalCase()}}ServiceImpl implements {{name.pascalCase()}}Service {
  {{name.pascalCase()}}ServiceImpl();
}
