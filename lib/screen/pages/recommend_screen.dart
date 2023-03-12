import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hipspot/component/Recommend/imageslider.dart';

Future<Post> fetchPost() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

  if (response.statusCode == 200) {
    // 만약 서버로의 요청이 성공하면, JSON을 파싱합니다.
    return Post.fromJson(json.decode(response.body));
  } else {
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({Key? key}) : super(key: key);

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  late Future<Post> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: const [
            ImageSlider(
                text: '현재 위치에서 가장 가까운 카페',
                subtext: '',
                list: [
                  'assets/images/recommends/recommend1.png',
                  'assets/images/recommends/recommend2.png',
                  'assets/images/recommends/recommend3.png',
                ]),
            ImageSlider(
                text: '후기가 좋은 카페',
                subtext: '리뷰수와 평점을 고려했어요',
                list: [
                  'assets/images/recommends/recommend1.png',
                  'assets/images/recommends/recommend2.png',
                  'assets/images/recommends/recommend3.png',
                ]),
            ImageSlider(
                text: '새로 오픈한 카페',
                subtext: '',
                list: [
                  'assets/images/recommends/recommend1.png',
                  'assets/images/recommends/recommend2.png',
                  'assets/images/recommends/recommend3.png',
                ]),
            ImageSlider(
                text: '또 가고싶은 카페',
                subtext: '많은 유저들이 즐겨찾기한 카페',
                list: [
                  'assets/images/recommends/recommend1.png',
                  'assets/images/recommends/recommend2.png',
                  'assets/images/recommends/recommend3.png',
                ]),
          ],
        ));
  }
}