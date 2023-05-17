import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hipspot/component/login.dart';
import 'package:hipspot/main.dart';
import 'package:hipspot/utils/token_storage.dart';

// 추후 const로 옮기기
const APP_REDIRECT_URI = "hipspot-mobile";
const GOOGLE_AUTH_URI_BASE = 'https://api.hipspot.xyz/auth/login/google';
const DEV_AUTH_URI = 'https://api.hipspot.xyz/auth/login/dev';

class Authenticate {
  final _dio = dio;
  static Future<bool> login() async {
    try {
      final result = await FlutterWebAuth.authenticate(
        url:
            '$DEV_AUTH_URI?platform=mobile', // 쿼리 형식으로 platform=mobile 이라는 값을 전달해주면, 서버에서 스케마에 맞게 자동 리다이렉트
        callbackUrlScheme: APP_REDIRECT_URI,
      );

      final String? accessToken =
          Uri.parse(result).queryParameters['access_token'];
      final String? refreshToken =
          Uri.parse(result).queryParameters['refresh_token'];

      print(
          "로그인 이후 accessToken:${accessToken!.substring(accessToken.length - 6)}, refreshToken:${refreshToken!.substring(refreshToken.length - 6)})}");
      if (accessToken == null || refreshToken == null) {
        throw Exception('토큰이 없습니다.');
      }

      await TokenStorage.writeTokens(
        accessToken: accessToken!,
        refreshToken: refreshToken!,
      );
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  static Future<bool> logout() async {
    return await TokenStorage.deleteTokens();
  }
}

void showLoginModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Login(),
  );
}
