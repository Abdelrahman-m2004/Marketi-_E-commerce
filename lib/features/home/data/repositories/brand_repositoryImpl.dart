import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/core/ApiService/api_services.dart';
import 'package:marketi/features/home/data/models/brand_model.dart';
import 'package:marketi/features/home/domain/repositories/brand_repository.dart';

class BrandRepositoryimpl implements BrandRepository{
  final ApiServices apiServices;

  BrandRepositoryimpl({
    required this.apiServices,
  });

  @override
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