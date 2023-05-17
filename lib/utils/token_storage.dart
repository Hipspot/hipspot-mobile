import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static Future<bool> writeTokens(
      {required String accessToken, required String refreshToken}) async {
    try {
      const storage = FlutterSecureStorage();

      await storage.write(key: 'refreshToken', value: refreshToken);
      await storage.write(key: 'accessToken', value: accessToken);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  static Future<bool> deleteTokens() async {
    try {
      const storage = FlutterSecureStorage();

      await storage.delete(key: 'refreshToken');
      await storage.delete(key: 'accessToken');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'accessToken');
  }

  static Future<String?> getRefreshToken() async {
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'refreshToken');
  }
}
