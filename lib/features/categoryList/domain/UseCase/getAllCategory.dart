import 'package:marketi/features/categoryList/domain/Entites/CategoryEntity.dart';
import 'package:marketi/features/categoryList/domain/repository/categoryRepository.dart';

class Getallcategory {
  final Categoryrepository repo;

  Getallcategory({required this.repo});
  Future<List<Categoryentity>> call() {
    return repo.GetAllCategory();
  }
}
