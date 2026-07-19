import 'package:dio/dio.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/core/Network/token_storage.dart';
import 'package:marketi/features/favscreen/data/models/FavModel.dart';

class favRemoteDataSourse {
  final ApiClient apiClient;

  favRemoteDataSourse({required this.apiClient});

  Future<FavModel> GetAllFavProducts() async {
    final token = await TokenStorage.getToken();

    final response = await apiClient.dio.get(
      Apiconstant.list_favorites,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return FavModel.fromJson(response.data);
  }
}
