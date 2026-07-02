import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/home/data/ApiService/api_services.dart';
import 'package:marketi/features/home/data/models/category_model.dart';

class CategoryRepository {
  final ApiServices apiServices;

  CategoryRepository({
    required this.apiServices,
  });

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiServices.get(
      endpoint: Apiconstant.List_category,
    );

    return (response['data'] as List)
        .map(
          (e) => CategoryModel.fromJson(e),
        )
        .toList();
  }
}