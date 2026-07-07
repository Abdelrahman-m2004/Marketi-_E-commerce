import 'package:marketi/core/ApiService/api_services.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

class ProductRemoteDatasource {
  final ApiServices apiServices;

  ProductRemoteDatasource({
    required this.apiServices,
  });

  Future<List<ProductModel>> getProducts() async {
    final response = await apiServices.get(
      endpoint: Apiconstant.List_products,
    );

    final List products = response['data']['data'];

    return products
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
