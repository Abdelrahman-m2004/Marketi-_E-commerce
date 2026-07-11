import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:marketi/core/Network/token_storage.dart';
import 'package:marketi/features/payment/data/models/payment_model.dart';

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

  Future<Map<String, dynamic>> sendOtp({required String phone}) async {
    final response = await dio.post(
      '/forgot-password',
      data: {'phone': phone},
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
  }) async {
    debugPrint('PHONE SENT: $phone');
    debugPrint('OTP SENT: $otp');

    final response = await dio.post(
      '/reset-password',
      data: {
        'phone': phone,
        'otp': otp,
        'password': password,
        'password_confirmation': password,
      },
    );

    debugPrint('RESET RESPONSE: ${response.data}');
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

    final requestData = {
      'delivery_address': deliveryAddress,
      'delivery_slot_id': deliverySlotId,
      'notes': notes,
      'payment_type': paymentType,
    };

    debugPrint('====== PLACE ORDER REQUEST ======');
    debugPrint('URL: /orders');
    debugPrint('TOKEN: $token');
    debugPrint('BODY: $requestData');
    debugPrint('=================================');

    final response = await dio.post(
      '/orders',
      data: requestData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    debugPrint('====== PLACE ORDER RESPONSE ======');
    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('DATA: ${response.data}');
    debugPrint('==================================');

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

    debugPrint('PAYMENT TOKEN: $token');

    final response = await dio.get(
      '/payments',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    debugPrint('PAYMENTS RESPONSE: ${response.data}');

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

    debugPrint('====== RETRY PAYMENT REQUEST ======');
    debugPrint('URL: https://marketi.newcinderella.online/api/v1/orders/$orderId/payment/retry');
    debugPrint('TOKEN: $token');
    debugPrint('===================================');

    final response = await dio.post(
      '/orders/$orderId/payment/retry',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    debugPrint('====== RETRY PAYMENT RESPONSE ======');
    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('DATA: ${response.data}');
    debugPrint('====================================');

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
}
