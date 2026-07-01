import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:marketi/core/Network/Api_client.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/core/Network/Error_Handling.dart';
import 'package:marketi/features/profile/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getProfile();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await apiClient.get(Apiconstant.get_profile);

      return UserModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handle(e));
    }
  }
}
