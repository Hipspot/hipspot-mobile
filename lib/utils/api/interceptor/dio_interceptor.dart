import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hipspot/component/login.dart';
import 'package:hipspot/main.dart';
import 'package:hipspot/utils/authenticate.dart';

class DioAddQueryInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = FlutterSecureStorage();

    String? accessToken = await storage.read(key: 'accessToken');
    String? refreshToken = await storage.read(key: 'refreshToken');

    print('요청전 토큰 확인, $accessToken, $refreshToken');

    if (accessToken == null && refreshToken == null) {
      DioError error = DioError(
          requestOptions: options,
          type: DioErrorType.cancel,
          error: "토큰이 없습니다.");
      handler.reject(error);
    }

    options.queryParameters.addAll({'platform': 'mobile'});

    options.headers['Authorization'] = 'Bearer ${accessToken!}';
    options.headers['Cookie'] = 'hipspot_refresh_token=${refreshToken!}';

    print('header --- ${options.headers}');

    handler.next(options);
    return;
  }
}

class DioUnAuthErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('onError 확인 ${err.type} , ${err.message}');
    if (err.response?.statusCode == 700) {
      print("700으로 코드 전달");
      print("에러 전 요청 주소, ${err.requestOptions.path}");
      print("받은 데이터 , ${err.response?.data}");
      var refreshToken = err.response?.data['refresh_token'];
      var accessToken = err.response?.data['access_token'];

      if (refreshToken == null || accessToken == null) {
        DioError newErr = DioError(
          requestOptions: err.requestOptions,
          type: err.type,
          message: "슬라이딩으로 받은 토큰이 없습니다,",
        );

        handler.next(newErr);
      }

      final storage = FlutterSecureStorage();
      await storage.write(key: 'refreshToken', value: refreshToken);
      await storage.write(key: 'accessToken', value: accessToken);

      Options options = Options(
        method: err.requestOptions.method,
      );

      Response response = await dio.request(
        err.requestOptions.path,
        data: err.requestOptions.data,
        options: options,
      );

      print("재요청 결과, $response");

      handler.resolve(response);
      return;
    }
    if (err.response?.statusCode == 401) {
      print('재로그인하세요, err: ${err.response?.statusMessage}');
      Response<dynamic>? response = err.response;
      print('header : ${err.requestOptions.headers}, response : $response');

      // Authenticate.login();
      return;
    }
    handler.next(err);
  }
}

class DioParseTokenInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}
