import 'package:bloc/bloc.dart';
import 'package:marketi/features/Splash/domain/usecases/GetIsFirstTime.dart';
import 'package:marketi/features/Splash/domain/usecases/SaveIsFirstTime.dart';
import 'package:meta/meta.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetIsFirstTime isFirstTime;
  final SaveIsFirstTime saveIsFirstTime;
  SplashCubit({required this.isFirstTime, required this.saveIsFirstTime})
    : super(SplashInitial());

  Future<void> ChackIsFristTime() async {
    final isFristTime = await isFirstTime();
    if (isFristTime) {
      emit(GoToOnboarding());
    } else {
      emit(GoToHome());
    }
  }
}
