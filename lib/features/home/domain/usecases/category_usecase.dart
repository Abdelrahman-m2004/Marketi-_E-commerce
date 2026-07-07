import 'package:marketi/features/home/data/models/category_model.dart';

import 'package:marketi/features/home/domain/repositories/category_repository.dart';

class CategoryUsecase {


  CategoryRepository repository;
  CategoryUsecase(this.repository);

  Future<List<CategoryModel>> call() {
    return repository.getCategory();
  }
}
