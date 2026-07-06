import 'package:dio/dio.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/favscreen/data/models/FavModel.dart';

class favRemoteDataSourse {
  final ApiClient apiClient;
  String token = '20|llxPimbD0Y3ez89uf8g22x5RtRTpyKeAbA9zM3SLb65fa22f';
  favRemoteDataSourse({required this.apiClient});
  Future<FavModel> GetAllFavProducts() async {
    final response = await apiClient.dio.get(
      Apiconstant.list_favorites,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return FavModel.fromJson(response.data);
  }
}
