import 'package:http/http.dart' as http;
import 'package:hipspot/utils/get_my_location.dart';

import '../model/recommend_page/closest.dart';
import '../model/recommend_page/high_rated.dart';
import '../model/recommend_page/newly_opened.dart';

class RemoteService {
  static const String baseUrl = 'https://api.hipspot.xyz/cafe/recommend/';

  Future<T?> getData<T>(String endpointUrl) async {
    var client = http.Client();

    String long = '';
    String lat = '';

    var position = await getMyLocation();
    long = '${position.longitude}'.substring(1);
    lat = '${position.latitude}';

    var uri = Uri.parse('$baseUrl$endpointUrl?startLng=$long&startLat=$lat');

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      if (T == List<Closest>) {
        return closestFromJson(json) as T?;
      } else if (T == List<HighRated>) {
        return highRatedFromJson(json) as T?;
      } else if (T == List<NewlyOpened>) {
        return newlyOpenedFromJson(json) as T?;
      }
    }
    return null;
  }
}