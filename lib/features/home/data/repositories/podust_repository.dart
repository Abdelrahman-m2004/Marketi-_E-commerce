import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/home/data/ApiService/api_services.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

class ProductRepository {
  final ApiServices apiServices;

  ProductRepository({
    required this.apiServices,
  });

  Future<List<ProductModel>> getProducts() async {
    final response = await apiServices.get(
      endpoint: Apiconstant.List_products,
    );

    return (response['data']['data'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}