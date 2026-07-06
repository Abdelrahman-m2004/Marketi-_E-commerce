import 'package:marketi/features/categoryList/domain/Entites/CategoryEntity.dart';

abstract class Categoryrepository {
  Future<List<Categoryentity>> GetAllCategory();
}
