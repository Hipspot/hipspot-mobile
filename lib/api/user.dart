import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hipspot/main.dart';

class UserApi {
  late Dio _client;
  late String path;

  UserApi() {
    _client = dio;
    path = '${dotenv.env['API_ROOT_PATH']!}/user';
  }

  Future<Response<dynamic>> get() async {
    var response = await _client.get(path);

    return response;
  }

  Future<bool> unRegister() async {
    try {
      await _client.delete(path);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}
