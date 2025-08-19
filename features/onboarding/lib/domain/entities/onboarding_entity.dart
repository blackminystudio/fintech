import 'package:core/core.dart';

class OnboardingEntity extends Equatable {
  const OnboardingEntity({required this.id});
  final String id;

  OnboardingEntity copyWith({String? id}) =>
      OnboardingEntity(id: id ?? this.id);

  @override
  List<Object?> get props => [id];
}
