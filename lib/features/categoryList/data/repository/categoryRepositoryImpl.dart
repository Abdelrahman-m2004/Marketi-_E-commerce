import 'package:marketi/features/categoryList/data/RemotDataSourse/categoryRemotDataSourse.dart';
import 'package:marketi/features/categoryList/domain/Entites/CategoryEntity.dart';
import 'package:marketi/features/categoryList/domain/repository/categoryRepository.dart';

class CategoryrepositoryImpl implements Categoryrepository {
  final categoryRemotDataSourse remoteDataSourse;

  CategoryrepositoryImpl(this.remoteDataSourse);

  @override
  Future<List<Categoryentity>> GetAllCategory() {
    return remoteDataSourse.GetAllCategory();
  }
}
