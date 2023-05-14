import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hipspot/main.dart';

class FavoriteApi {
  late Dio _client;
  late String path;
  late String? accessToken;

  FavoriteApi() {
    _client = dio;
    path = '${dotenv.env['API_ROOT_PATH']!}/favorite?platform=mobile';
  }

  Future<Response<dynamic>> getFavoriteList() async {
    print("getFavoriteList, $path");
    var response = await _client.get(path,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}));

    return response;
  }

  Future<bool> addFavorite(String cafeId) async {
    return true;
  }
}
