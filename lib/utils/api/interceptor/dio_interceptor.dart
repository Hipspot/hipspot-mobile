import 'package:dio/dio.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:hipspot/component/login.dart';

class DioAddQueryInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({'platform': 'mobile'});
    print('dio요청, ${options.queryParameters}');
    super.onRequest(options, handler);
  }
}

class DioUnAuthErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final result = await FlutterWebAuth.authenticate(
        url:
            '$GOOGLE_AUTH_URI_BASE?platform=mobile', // 쿼리 형식으로 platform=mobile 이라는 값을 전달해주면, 서버에서 스케마에 맞게 자동 리다이렉트
        callbackUrlScheme: APP_REDIRECT_URI,
      );
    }
    // super.onError(err, handler);
  }
}
