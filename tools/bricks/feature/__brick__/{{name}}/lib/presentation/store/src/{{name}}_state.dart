import 'package:core/core.dart';

import '../../../domain/entities/{{name}}_entity.dart';

enum {{name.pascalCase()}}Status { loading, completed, error }

class {{name.pascalCase()}}State extends Equatable {
  const {{name.pascalCase()}}State({
    this.status = {{name.pascalCase()}}Status.loading,
    this.{{name}}Entity,
    this.exception,
  });

  final {{name.pascalCase()}}Status status;
  final {{name.pascalCase()}}Entity? {{name}}Entity;
  final AppException? exception;

  {{name.pascalCase()}}State copyWith({
    {{name.pascalCase()}}Entity? {{name}}Entity,
    {{name.pascalCase()}}Status? status,
    AppException? exception,
  }) => {{name.pascalCase()}}State(
    {{name}}Entity: {{name}}Entity ?? this.{{name}}Entity,
    status: status ?? this.status,
    exception: exception,
  );

  @override
  List<Object?> get props => [{{name}}Entity, exception, status];
}
