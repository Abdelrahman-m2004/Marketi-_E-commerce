import 'package:marketi/features/home/data/models/category_model.dart';

abstract class CategoryRepository{
    Future<List<CategoryModel>> getCategory();
}