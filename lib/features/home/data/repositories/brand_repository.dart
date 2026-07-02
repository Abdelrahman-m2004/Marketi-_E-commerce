import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/home/data/ApiService/api_services.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';

class BrandRepository {
  final ApiServices apiServices;

  BrandRepository({
    required this.apiServices,
  });

  Future<List<BrandModel>> getBrands() async {
    final response = await apiServices.get(
      endpoint: Apiconstant.List_Brands,
    );

    return (response['data'] as List)
        .map(
          (e) => BrandModel.fromJson(e),
        )
        .toList();
  }
}