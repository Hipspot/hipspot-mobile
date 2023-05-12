import 'package:flutter/material.dart';
import 'package:hipspot/component/Recommend/Recommend.dart';
import 'package:hipspot/const/texts.dart';
import 'package:hipspot/services/remote_service.dart';

import '../../model/recommend_page/closest.dart';
import '../../model/recommend_page/high_rated.dart';
import '../../model/recommend_page/newly_opened.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({Key? key}) : super(key: key);

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  List<Closest>? closestList;
  List<HighRated>? highRatedList;
  List<NewlyOpened>? newlyOpenedList;

  var allLoaded = false;

  @override
  void initState() {
    super.initState();
    // fetch data from API
    getData();
  }

  getData() async {
    closestList = await RemoteService().getClosest();
    highRatedList = await RemoteService().getHighRated();
    newlyOpenedList = await RemoteService().getNewlyOpened();

    if (closestList != null && highRatedList != null && newlyOpenedList != null) {
      setState(() {
        allLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: allLoaded,
      replacement: const Center(
          child: CircularProgressIndicator()
      ),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // map 해보기
              // 3장만 받지 말고 있는 사진 다 가져오기
              ImageSlider(
                  text: Texts.closestText.toString(),
                  subtext: Texts.closestSubText.toString(),
                  list: closestList?.map((e) => e.imageUrl[0]).toList() ?? []),
              ImageSlider(
                  text: Texts.highRatedText.toString(),
                  subtext: Texts.highRatedSubText.toString(),
                  list: highRatedList?.map((e) => e.imageUrl[0]).toList() ?? []),
              ImageSlider(
                  text: Texts.newlyOpenedText.toString(),
                  subtext: Texts.newlyOpenedSubText.toString(),
                  list: newlyOpenedList?.map((e) => e.imageUrl[0]).toList() ?? []),
              ImageSlider(
                  text: Texts.popularText.toString(),
                  subtext: Texts.popularSubText.toString(),
                  list: closestList?.map((e) => e.imageUrl[0]).toList() ?? []),
            ],
          )),
    );
  }
}
