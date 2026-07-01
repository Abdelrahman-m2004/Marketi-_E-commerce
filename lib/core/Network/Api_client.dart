import 'package:dio/dio.dart';

import 'package:marketi/core/Network/ApiInterceptors.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/core/Network/Error_Handling.dart';

class ApiClient {
  late final Dio dio;
  ApiClient() {
    dio = Dio(BaseOptions(baseUrl: Apiconstant.baseUrl));
    dio.interceptors.add(AppInterceptor());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryparameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryparameters);
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handle(e));
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handle(e));
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      throw Exception(ApiErrorHandler.handle(e));
    }
  }
}
