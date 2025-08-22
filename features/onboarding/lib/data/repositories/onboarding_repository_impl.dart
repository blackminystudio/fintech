import 'package:core/core.dart';

import '../../domain/entities/onboarding_entity.dart';
import '../../domain/onboarding_types.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../models/onboarding_model.dart';
import '../services/onboarding_service.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl extends OnboardingRepository {
  OnboardingRepositoryImpl(this.service);
  OnboardingService service;

  @override
  FutureEitherOnboardingEntity fetchOnboardingData() async {
    try {
      final model = await service.fetchData();
      final entity = model.toEntity();
      return Right(entity);
    } catch (e, st) {
      return Left(AppException.fromService(e, st));
    }
  }

  @override
  FutureEitherOnboarding updateOnboardingData(OnboardingEntity entity) async {
    try {
      service.updateData(OnboardingModel.fromEntity(entity));
      return const Right(unit);
    } catch (e, st) {
      return Left(AppException.fromService(e, st));
    }
  }
}
