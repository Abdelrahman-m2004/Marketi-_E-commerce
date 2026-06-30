import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/core/Network/Error_Handling.dart';
import 'package:marketi/features/brands/data/models/brand_model.dart';

abstract class BrandsRemoteDataSource {
  Future<List<BrandModel>> getBrands();
}

@LazySingleton(as: BrandsRemoteDataSource)
class BrandsRemoteDataSourceImpl implements BrandsRemoteDataSource {
  final ApiClient _apiClient;

  BrandsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<BrandModel>> getBrands() async {
    try {
      final response = await _apiClient.get(Apiconstant.List_Brands);
      return (response.data['data'] as List)
          .map((e) => BrandModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handle(e));
    }
  }
}
