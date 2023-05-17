import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hipspot/main.dart';

class FavoriteApi {
  late Dio _client;
  late String path;
  late String? accessToken;

  FavoriteApi() {
    _client = dio;
    path = '${dotenv.env['API_ROOT_PATH']!}/favorite';
  }

  Future<Response<dynamic>> getList() async {
    var response = await _client.get(path);

    return response;
  }

  Future<bool> toggle(String cafeId, bool isBookmarked) async {
    print('toggle, $cafeId, $isBookmarked ');
    return isBookmarked ? remove(cafeId) : add(cafeId);
  }

  Future<bool> add(String cafeId) async {
    try {
      await _client.patch(path, data: {'type': "add", 'cafeId': cafeId});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> remove(String cafeId) async {
    try {
      await _client.patch(path, data: {'type': 'remove', 'cafeId': cafeId});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}
