import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hipspot/component/login.dart';

class DioAddQueryInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({'platform': 'mobile'});
    var headers = options.headers;
    var auth = headers['Authorization'];
    var cookies = headers['Cookie'];

    print(
        'header --- ${options.headers}, auth --- $auth, cookies --- $cookies');

    handler.next(options);
  }
}

class DioUnAuthErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      print('재로그인하세요');
    }
    handler.next(err);
  }
}
