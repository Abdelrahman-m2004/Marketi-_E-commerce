import 'package:marketi/features/Onbording/domain/entities/onboarding_entites.dart';

abstract class OnboardingRepository {
  Future<List<onboardingEntities>> getOnboardingData();
}
