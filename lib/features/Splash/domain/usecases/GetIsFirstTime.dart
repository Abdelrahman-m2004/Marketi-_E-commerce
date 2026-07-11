import 'package:marketi/features/Splash/domain/repositories/spalshRepositories.dart';

class GetIsFirstTime {
  final spalshrepository repos;

  GetIsFirstTime({required this.repos});

  Future<bool> call() {
    return repos.getIsFirstTimr();
  }
}
