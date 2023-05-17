import 'package:dio/dio.dart';
import 'package:hipspot/main.dart';
import 'package:hipspot/utils/token_storage.dart';

class DioOnRequestInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await TokenStorage.getAccessToken();
    String? refreshToken = await TokenStorage.getRefreshToken();

    print('요청전 토큰 확인, $accessToken, $refreshToken');

    /**
     * 토큰 관련 유효성 체크는 서버에서 진행하므로 토큰 둘 다 없을 시에만 에러처리
     *
     */
    if (accessToken == null && refreshToken == null) {
      DioError error = DioError(
          requestOptions: options,
          type: DioErrorType.cancel,
          error: "토큰이 없습니다.");
      handler.reject(error);
    }

    /**
     * 매 요청 전에 쿼리 추가, 엑세스토큰, 리프레시토큰 추가
     */
    options.queryParameters.addAll({'platform': 'mobile'});
    options.headers['Authorization'] = 'Bearer ${accessToken!}';
    options.headers['Cookie'] = 'hipspot_refresh_token=${refreshToken!}';

    print('header --- ${options.headers}');
    handler.next(options);
    return;
  }
}

class DioOnErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('onError 확인 ${err.type} , ${err.message}');
    var originResponse = err.response;

    if (originResponse?.statusCode == 700) {
      /**
       * 상태코드 700으로 온 경우, 서버에서 토큰 전달해준 상황
       * 메시지 body에서 토큰 파싱.
       */
      var body = originResponse?.data;
      var refreshToken = body['refresh_token'];
      var accessToken = body['access_token'];

      /**
       * 토큰 없는 경우, 다시 에러 처리
       */
      if (refreshToken == null || accessToken == null) {
        DioError newErr = await exceptionError(err, "토큰이 없습니다.");
        handler.next(newErr);
      }

      /**
       * 새로운 토큰 sequre storage에 저장해서 최신화.
       * 매 응답마다 DioOnRequestInterCeptor에서 스토리지의 토큰을 조회하므로
       * 저장만하면 자동으로 최신화된 토큰 사용함.
       */
      await TokenStorage.writeTokens(
          accessToken: accessToken, refreshToken: refreshToken);

      /**
       * 새로운 토큰으로 기존 요청 url로 재요청,
       * 요청 이후 받은 응답 resolve
       */
      Response response = await reRequestToOrigin(err);
      handler.resolve(response);
      return;
    }

    /**
     * 401 상태코드로 에러가 발생한 경우 엑세스토큰, 리프레시토큰 모두 유효하지 않은 상황
     * 재 로그인 처리
     * 작성예정
     */
    if (err.response?.statusCode == 401) {
      print('재로그인하세요, err: ${err.response?.statusMessage}');
      Response<dynamic>? response = err.response;
      print('header : ${err.requestOptions.headers}, response : $response');

      // Authenticate.login();
      return;
    }
    handler.next(err);
  }

  // 실패한 요청 재요청하는 메서드
  reRequestToOrigin(DioError err) async {
    Response response = await dio.request(err.requestOptions.path,
        data: err.requestOptions.data,
        options: Options(
          method: err.requestOptions.method,
        ));
    return response;
  }

  exceptionError(DioError err, String message) async {
    DioError newErr = DioError(
      requestOptions: err.requestOptions,
      type: err.type,
      message: message,
    );
    return newErr;
  }
}
