import 'package:marketi/core/ApiService/api_services.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';

class BrandRemoteDatesource {
  final ApiServices apiServices;

  BrandRemoteDatesource({required this.apiServices});

  Future<List<BrandModel>> getBrands() async {
    final response = await apiServices.get(
      endpoint: Apiconstant.List_Brands,
    );

    final List products = response['data'];

    return products
        .map((e) => BrandModel.fromJson(e))
        .toList();
  }
}