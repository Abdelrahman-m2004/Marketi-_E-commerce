import 'package:marketi/features/home/data/data_source/category_remote_datesourse.dart';
import 'package:marketi/features/home/data/models/category_model.dart';
import 'package:marketi/features/home/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryRemoteDatesourse categoryRemoteDatesourse;

  CategoryRepositoryImpl({required this.categoryRemoteDatesourse});
  @override
  Future<List<CategoryModel>> getCategory() async{
   return  await categoryRemoteDatesourse.getCategorys();
  }

  

  
}