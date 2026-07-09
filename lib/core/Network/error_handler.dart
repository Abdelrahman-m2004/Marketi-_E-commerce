import 'package:dio/dio.dart';

class ErrorHandler {
  static String parse(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;

      //  message من الـ response
      if (data is Map) {
        final message = data['message'];
        if (message != null && message.toString().isNotEmpty) {
          return message.toString();
        }

        // validation errors
        final errors = data['errors'];
        if (errors is Map) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
        }
      }

      // HTTP status fallback
      switch (error.response?.statusCode) {
        case 400: return 'Bad request. Please check your input.';
        case 401: return 'Unauthorized. Please log in again.';
        case 403: return 'Access denied.';
        case 404: return 'Resource not found.';
        case 422: return 'Invalid data. Please check your input.';
        case 429: return 'Too many requests. Please try again later.';
        case 500: return 'Server error. Please try again later.';
        case 503: return 'Service unavailable. Please try again later.';
        default:  return 'Something went wrong. Please try again.';
      }
    }

    // غير Dio error
    final msg = error.toString().replaceAll('Exception: ', '');
    if (msg.contains('<html') || msg.contains('DOCTYPE')) {
      return 'Server error. Please try again later.';
    }
    return msg.isNotEmpty ? msg : 'Something went wrong.';
  }
}
