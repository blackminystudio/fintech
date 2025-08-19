import 'package:core/core.dart';

import '../../domain/repositories/onboarding_repository.dart';
import 'src/onboarding_state.dart';
import 'src/onboarding_store.dart';

final onboardingRepoProvider = Provider<OnboardingRepository>(
  (ref) => getIt<OnboardingRepository>(),
);

final onboardingStoreProvider =
    StateNotifierProvider<OnboardingStore, OnboardingState>(
      OnboardingStore.new,
    );
