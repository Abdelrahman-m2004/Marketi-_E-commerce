import 'package:dio/dio.dart';
import 'package:marketi/core/service/flutter_secoure_storge.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';

    final token = await SecureStorageService.instance.getToken();

    options.headers['Authorization'] =
        'Bearer 21|d3moqPLkHoZydt7KJUImYOMFne92LzoMWYaUEO75374fe026';

    print(options.headers);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await SecureStorageService.instance.deleteToken();
      // navigate to login
    }

    handler.next(err);
  }
}
