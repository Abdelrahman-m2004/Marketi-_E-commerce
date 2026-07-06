part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {
  final List<onboardingEntities> OnboardingList;
  final int CurrentIndex;

  OnboardingLoaded({required this.OnboardingList, required this.CurrentIndex});
}

final class GoToHome extends OnboardingState {}
