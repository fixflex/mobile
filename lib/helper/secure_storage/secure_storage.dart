import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static late FlutterSecureStorage secureStorage;

  static void init() {
    secureStorage = const FlutterSecureStorage();
  }

  static Future<void> saveData({
    required String key,
    required String value,
  }) async {
    return await secureStorage.write(key: key, value: value);
  }

  static Future<dynamic> getData({
    required String key,
  }) async {
    return await secureStorage.read(key: key);
  }

  static Future<dynamic> deleteData({
    required String key,
  }) async {
    return await secureStorage.delete(key: key);
  }
}
