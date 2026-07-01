import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static final SecureStorageService instance = SecureStorageService._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String accessTokenKey = 'access_token';

  Future<void> saveToken(String token) async {
    await _storage.write(key: accessTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: accessTokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: accessTokenKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
