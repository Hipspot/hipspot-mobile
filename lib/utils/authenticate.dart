import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hipspot/component/login.dart';
import 'package:hipspot/main.dart';

// 추후 const로 옮기기
const APP_REDIRECT_URI = "hipspot-mobile";
const GOOGLE_AUTH_URI_BASE = 'https://api.hipspot.xyz/auth/login/google';
const DEV_AUTH_URI = 'https://api.hipspot.xyz/auth/login/dev';

class Authenticate {
  static Future<bool> login() async {
    final _dio = dio;

    try {
      final result = await FlutterWebAuth.authenticate(
        url:
            '$DEV_AUTH_URI?platform=mobile', // 쿼리 형식으로 platform=mobile 이라는 값을 전달해주면, 서버에서 스케마에 맞게 자동 리다이렉트
        callbackUrlScheme: APP_REDIRECT_URI,
      );

      print("auth $result");

      final String? accessToken =
          Uri.parse(result).queryParameters['access_token'];
      final String? refreshToken =
          Uri.parse(result).queryParameters['refresh_token'];

      if (accessToken == null || refreshToken == null)
        throw Exception('토큰이 없습니다.');

      await Authenticate.writeTokens(
        accessToken: accessToken!,
        refreshToken: refreshToken!,
      );
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  static Future<bool> logout() async {
    const storage = FlutterSecureStorage();
    final _dio = dio;
    try {
      storage.delete(key: 'refreshToken');
      storage.delete(key: 'accessToken');
      print('로그아웃 완료');
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  static Future<bool> writeTokens(
      {required String accessToken, required String refreshToken}) async {
    final storage = FlutterSecureStorage();
    try {
      await storage.write(key: 'refreshToken', value: refreshToken);
      await storage.write(key: 'accessToken', value: accessToken);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}

void showLoginModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Login(),
  );
}
