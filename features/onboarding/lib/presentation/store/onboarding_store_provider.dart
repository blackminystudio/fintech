import 'package:core/core.dart';

import '../../domain/repositories/onboarding_repository.dart';
import '../../domain/use_cases/fetch_data.dart';
import '../../domain/use_cases/update_data.dart';
import 'src/onboarding_state.dart';
import 'src/onboarding_store.dart';

final fetchDataProvider = Provider<FetchData>(
  (ref) => FetchData(ref.read(onboardingRepoProvider)),
);

final onboardingRepoProvider = Provider<OnboardingRepository>(
  (ref) => getIt<OnboardingRepository>(),
);

final onboardingStoreProvider =
    StateNotifierProvider<OnboardingStore, OnboardingState>(
      OnboardingStore.new,
    );
final updateDataProvier = Provider<UpdateData>(
  (ref) => UpdateData(ref.read(onboardingRepoProvider)),
);
