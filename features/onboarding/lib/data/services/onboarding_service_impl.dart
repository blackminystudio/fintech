import 'package:core/core.dart';

import '../models/onboarding_model.dart';
import 'onboarding_service.dart';

@LazySingleton(as: OnboardingService)
class OnboardingServiceImpl implements OnboardingService {
  OnboardingServiceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  @override
  Future<OnboardingModel> fetchData() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw const AppException(
        code: 'unauthenticated',
        source: 'Firestore',
        errorType: ErrorType.unauthenticated,
        message: 'User is not authenticated',
      );
    }

    final doc =
        await firebaseFirestore
            .collection('user')
            .doc(user.uid)
            .collection('profile')
            .doc('info')
            .get();

    if (!doc.exists) {
      throw const AppException(
        code: 'not-found',
        source: 'Firestore',
        errorType: ErrorType.documentNotFound,
        message: 'Requested document not found',
      );
    }
    return OnboardingModel.fromJson(doc.data()!);
  }

  @override
  Future<void> updateData(OnboardingModel model) async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      await firebaseFirestore
          .collection('user')
          .doc(user.uid)
          .collection('profile')
          .doc('info')
          .update(model.toJson());
    }
  }
}
