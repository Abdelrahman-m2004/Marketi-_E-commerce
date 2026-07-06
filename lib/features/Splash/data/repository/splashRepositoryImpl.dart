import 'package:marketi/features/Splash/data/dataSourse/splashLocalData.dart';
import 'package:marketi/features/Splash/domain/repositories/spalshRepositories.dart';

class Splashrepositoryimpl implements spalshrepository {
  final Splashlocaldata LocalData;

  Splashrepositoryimpl({required this.LocalData});
  @override
  Future<bool> SaveIsFirstTimr(bool value) {
    return LocalData.saveFristTime(value);
  }

  @override
  Future<bool> getIsFirstTimr() {
    return LocalData.getIsFirstTime();
  }
}
