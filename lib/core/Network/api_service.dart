import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marketi/core/Network/token_storage.dart';
import 'package:marketi/core/Network/Apiconstant.dart';
import 'package:marketi/features/payment/data/models/payment_model.dart';
import 'dart:io';

class ApiService {
  // Singleton instance لضمان نفس الـ Dio session بين الـ requests
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio dio;

  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://marketi.newcinderella.online/api/v1',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'User-Agent': 'MarkeriApp/1.0',
          'X-Requested-With': 'XMLHttpRequest',
        },
      ),
    );
  }

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

  Future<Map<String, dynamic>> sendOtp({required String phone}) async {
    final response = await dio.post(
      '/forgot-password',
      data: {'phone': phone},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> sendOtpByEmail({required String email}) async {
    final response = await dio.post(
      '/forgot-password',
      data: {'email': email},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await dio.post(
      '/verify-otp',
      data: {'phone': phone, 'otp': otp},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> resetPassword({
    required String phone,
    required String otp,
    required String password,
    String? resetToken,
  }) async {
    final response = await dio.post(
      '/reset-password',
      data: {
        'phone': phone,
        'otp': otp,
        'password': password,
        'password_confirmation': password,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> addFavorite(int productId) async {
    final token = await TokenStorage.getToken();
    final response = await dio.post(
      '/favorites',
      data: {'product_id': productId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> removeFavorite(int productId) async {
    final token = await TokenStorage.getToken();
    final response = await dio.delete(
      '/favorites/$productId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> addToCart({
    required int productId,
    required int quantity,
    String? size,
  }) async {
    final token = await TokenStorage.getToken();
    final response = await dio.post(
      '/cart/items',
      data: {
        'product_id': productId,
        'quantity': quantity,
        if (size != null && size.isNotEmpty) 'size': size,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> removeCartItem(int itemId) async {
    final token = await TokenStorage.getToken();
    final response = await dio.delete(
      '/cart/items/$itemId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getCart() async {
    final token = await TokenStorage.getToken();

    final response = await dio.get(
      '/cart',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> updateCartItem({
    required int itemId,
    required int quantity,
  }) async {
    final token = await TokenStorage.getToken();

    final response = await dio.put(
      '/cart/items/$itemId',
      data: {'quantity': quantity},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> placeOrder({
    required String deliveryAddress,
    required int deliverySlotId,
    required String notes,
    required String paymentType,
  }) async {
    final token = await TokenStorage.getToken();

    final response = await dio.post(
      '/orders',
      data: {
        'delivery_address': deliveryAddress,
        'delivery_slot_id': deliverySlotId,
        'notes': notes,
        'payment_type': paymentType,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getOrders() async {
    final token = await TokenStorage.getToken();

    final response = await dio.get(
      '/orders',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    final token = await TokenStorage.getToken();

    final response = await dio.get(
      '/orders/$orderId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<List<PaymentModel>> getPayments() async {
    final token = await TokenStorage.getToken();

    final response = await dio.get(
      '/payments',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final List payments = response.data['data']['data'];
    return payments.map((p) => PaymentModel.fromJson(p)).toList();
  }

  Future<Map<String, dynamic>> cancelOrder(int orderId) async {
    final token = await TokenStorage.getToken();

    final response = await dio.post(
      '/orders/$orderId/cancel',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> retryPayment(int orderId) async {
    final token = await TokenStorage.getToken();

    final response = await dio.post(
      '/orders/$orderId/payment/retry',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> completeMockPayment(int paymentId) async {
    final token = await TokenStorage.getToken();

    final response = await dio.post(
      '/payments/mock/$paymentId/complete',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> uploadProfileImage(File imageFile) async {
    final token = await TokenStorage.getToken();
    final formData = FormData.fromMap({
      'profile_image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
      '_method': 'PUT',
    });
    final response = await dio.post(
      Apiconstant.update_profile,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    return response.data;
  }
}
