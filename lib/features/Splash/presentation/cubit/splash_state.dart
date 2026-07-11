part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class splshloaded extends SplashState {}

final class GoToOnboarding extends SplashState {}

final class GoToHome extends SplashState {}
