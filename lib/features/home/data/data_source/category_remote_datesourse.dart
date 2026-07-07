import 'package:marketi/core/ApiService/api_services.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/home/data/models/category_model.dart';

class CategoryRemoteDatesourse {
  final ApiServices apiServices;

  CategoryRemoteDatesourse({required this.apiServices});

  Future<List<CategoryModel>> getCategorys() async {
    final response = await apiServices.get(
      endpoint: Apiconstant.List_category,
    );

    final List products = response['data'];

    return products
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }
}