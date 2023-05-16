import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hipspot/component/login.dart';
import 'package:hipspot/utils/authenticate.dart';

class DioAddQueryInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = FlutterSecureStorage();
    options.queryParameters.addAll({'platform': 'mobile'});
    options.headers['Authorization'] ??=
        'Bearer ${await storage.read(key: 'accessToken')}';
    options.headers['Cookies'] ??=
        'hipspot_refresh_token=${await storage.read(key: 'refreshToken')}';

    print(
        'header --- ${options.headers}, auth --- ${options.headers['Autorization']}, cookies --- ${options.headers['Cookies']}');

    handler.next(options);
  }
}

class DioUnAuthErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      print('재로그인하세요, err: ${err.response?.statusMessage}');
    }
    handler.next(err);
  }
}
