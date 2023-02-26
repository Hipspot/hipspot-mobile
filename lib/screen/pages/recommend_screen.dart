import 'package:flutter/material.dart';
import 'package:hipspot/component/Recommend/imageslider.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({Key? key}) : super(key: key);

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
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