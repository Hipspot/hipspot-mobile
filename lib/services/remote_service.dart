import 'package:hipspot/model/recommend_page/newly_opened.dart';
import 'package:hipspot/utils/get_my_location.dart';

import '../const/api_list.dart';
import '../model/recommend_page/closest.dart';
import '../model/recommend_page/high_rated.dart';
import 'package:http/http.dart' as http;



class RemoteService {
  Future<List<Closest>?> getClosest() async {
    var client = http.Client();

    String long = '';
    String lat = '';

    var position = await getMyLocation();
    long = '${position.longitude}'.substring(1);
    lat = '${position.latitude}';

    var uri = Uri.parse(("${ApiList.closestApi}startLng=$long&startLat=$lat"));

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return closestFromJson(json);
    }
    return null;
  }

  Future<List<HighRated>?> getHighRated() async {
    var client = http.Client();

    var uri = Uri.parse(ApiList.highRatedApi.toString());
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return highRatedFromJson(json);
    }
    return null;
  }

  Future<List<NewlyOpened>?> getNewlyOpened() async {
    var client = http.Client();

    String long = '';
    String lat = '';

    var position = await getMyLocation();
    long = '${position.longitude}'.substring(1);
    lat = '${position.latitude}';

    var uri = Uri.parse("${ApiList.newlyOpenedApi}startLng=$long&startLat=$lat");

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return newlyOpenedFromJson(json);
    }
    return null;
  }


}