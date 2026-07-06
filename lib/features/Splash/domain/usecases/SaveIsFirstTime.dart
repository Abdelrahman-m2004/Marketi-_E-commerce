import 'package:marketi/features/Splash/domain/repositories/spalshRepositories.dart';

class SaveIsFirstTime {
  final spalshrepository repos;

  SaveIsFirstTime({required this.repos});

  Future<bool> call(bool value) {
    return repos.SaveIsFirstTimr(value);
  }
}
