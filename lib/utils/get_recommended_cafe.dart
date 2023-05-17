import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// n 지우고 바로바로 data[n-1]['imageUrl'][0] 이런식으로 작성
// 한 번만 호출하고 위에처럼 사용
Future<String> getRecommendedCafe() async {
  final response = await http
      .get(Uri.parse('https://api.hipspot.xyz/cafe/recommend/high-rated'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getRecommendedCafe(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
