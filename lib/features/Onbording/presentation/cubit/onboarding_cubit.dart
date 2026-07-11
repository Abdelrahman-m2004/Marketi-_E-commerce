import 'package:bloc/bloc.dart';
import 'package:marketi/features/Onbording/domain/entities/onboarding_entites.dart';
import 'package:marketi/features/Onbording/domain/repository/OnboardingRepository.dart';
import 'package:marketi/features/Splash/domain/usecases/SaveIsFirstTime.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repo;
  final SaveIsFirstTime saveIsFirstTime;
  OnboardingCubit(this.repo, this.saveIsFirstTime) : super(OnboardingInitial());

  int currentindex = 0;
  List<onboardingEntities> OnboardingList = [];
  Future<void> loadOnboarding() async {
    emit(OnboardingLoading());

    OnboardingList = await repo.getOnboardingData();

    emit(
      OnboardingLoaded(
        OnboardingList: OnboardingList,
        CurrentIndex: currentindex,
      ),
    );
  }

  void changePage(int index) {
    currentindex = index;
    emit(
      OnboardingLoaded(
        OnboardingList: OnboardingList,
        CurrentIndex: currentindex,
      ),
    );
  }

  Future<void> finishOnboarding() async {
    await saveIsFirstTime(false);
    emit(GoToHome());
  }

  bool get isLastPage => currentindex == OnboardingList.length - 1;
}
