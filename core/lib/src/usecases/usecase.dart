// ignore_for_file: public_member_api_docs

import '../../core.dart';

abstract class UseCase<Type, Params, Repo> {
  Repo get repo;

  Future<Either<AppException, Type>> call(Params param);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class IDParams extends Equatable {
  const IDParams({required this.id});
  final String id;

  @override
  List<Object?> get props => [id];
}

class PaginationParams extends Equatable {
  const PaginationParams({required this.page});
  final int page;

  @override
  List<Object?> get props => [page];
}
