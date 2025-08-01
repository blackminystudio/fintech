import 'package:core/core.dart';

class {{name.pascalCase()}}Entity extends Equatable {
  const {{name.pascalCase()}}Entity({required this.id});
  final String id;

  {{name.pascalCase()}}Entity copyWith({String? id}) => {{name.pascalCase()}}Entity(id: id ?? this.id);

  @override
  List<Object?> get props => [id];
}
