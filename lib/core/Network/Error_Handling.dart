import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection Timeout';

      case DioExceptionType.sendTimeout:
        return 'Send Timeout';

      case DioExceptionType.receiveTimeout:
        return 'Receive Timeout';

      case DioExceptionType.connectionError:
        return 'No Internet Connection';

      case DioExceptionType.badResponse:
        final data = error.response?.data;

        if (data is Map<String, dynamic>) {
          return data['message'] ??
              _handleStatusCode(error.response?.statusCode);
        }

        return _handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Request Cancelled';

      default:
        return 'Unexpected Error';
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';

      case 401:
        return 'Unauthorized';

      case 403:
        return 'Forbidden';

      case 404:
        return 'Not Found';

      case 422:
        return 'Validation Error';

      case 500:
        return 'Internal Server Error';

      default:
        return 'Something Went Wrong';
    }
  }
}
