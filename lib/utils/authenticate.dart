// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hipspot/component/login.dart';
import 'package:hipspot/const/auth/keys.dart';
import 'package:hipspot/const/auth/target_oauth.dart';
import 'package:hipspot/utils/token_storage.dart';

// 추후 const로 옮기기
const APP_REDIRECT_URI = "hipspot-mobile";

class Authenticate {
  static Future<bool> login(TargetOauthEnum targetOauth) async {
    try {
      final result = await FlutterWebAuth.authenticate(
        url:
            '${targetOauth.url}?platform=mobile', // 쿼리 형식으로 platform=mobile 이라는 값을 전달해주면, 서버에서 스케마에 맞게 자동 리다이렉트
        callbackUrlScheme: APP_REDIRECT_URI,
      );

      final String? accessToken =
          Uri.parse(result).queryParameters[ACCESS_TOKEN_KEY];
      final String? refreshToken =
          Uri.parse(result).queryParameters[REFRESH_TOKEN_KEY];

      if (accessToken == null || refreshToken == null) {
        throw Exception('토큰이 없습니다.');
      }
      print(
          "로그인 이후 accessToken:${accessToken!.substring(accessToken.length - 6)}, refreshToken:${refreshToken!.substring(refreshToken.length - 6)})}");

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
