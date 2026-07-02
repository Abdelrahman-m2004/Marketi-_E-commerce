import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://marketi.newcinderella.online/api/v1',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/login',
      data: {
        'identifier': email,
        'password': password,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String username,
    required String phone,
    required String countryPhoneCode,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/register',
      data: {
        'name': name,
        'username': username,
        'phone': phone,
        'country_phone_code': countryPhoneCode,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },

    );

    return response.data;
  }
  Future<Map<String, dynamic>> sendOtp({
    required String phone,
  }) async {
    final response = await dio.post(
      '/forgot-password',
      data: {
        'phone': phone,
      },
    );

    return response.data;
  }
  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await dio.post(
      '/verify-otp',
      data: {
        'phone': phone,
        'otp': otp,
      },
    );

    return response.data;
  }
  Future<Map<String, dynamic>> resetPassword({
    required String phone,
    required String password,
  }) async {
    final response = await dio.post(
      '/reset-password',
      data: {
        'phone': phone,
        'password': password,
        'password_confirmation': password,
      },
    );

    return response.data;
  }
}