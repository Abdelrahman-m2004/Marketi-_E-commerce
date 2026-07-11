import 'package:marketi/features/Onbording/data/dataSourse/OnboardingLocalDataSourse.dart';
import 'package:marketi/features/Onbording/domain/entities/onboarding_entites.dart';
import 'package:marketi/features/Onbording/domain/repository/OnboardingRepository.dart';

class Onboardingrepoimpli implements OnboardingRepository {
  final Onboardinglocaldatasourse localData;

  Onboardingrepoimpli(this.localData);

  @override
  Future<List<onboardingEntities>> getOnboardingData() {
    return localData.GetOnboardingLocalData();
  }
}
