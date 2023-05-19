import 'package:flutter/material.dart';
import 'package:hipspot/component/Recommend/Recommend.dart';
import 'package:hipspot/const/recommend_title_text_enum.dart';
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

    if (closestList != null &&
        highRatedList != null &&
        newlyOpenedList != null) {
      setState(() {
        allLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: allLoaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // map 해보기
              // 3장만 받지 말고 있는 사진 다 가져오기
              Recommend(
                title: RecommendTitleTextEnum.closestText.toString(),
                subtitle: RecommendTitleTextEnum.closestSubText.toString(),
                cafeImageUrlList: closestList?.map((e) => e.imageUrl[0]).toList() ?? [],
                cafeName: closestList?.map((e) => e.cafeName).toList() ?? [],
              ),
              Recommend(
                title: RecommendTitleTextEnum.highRatedText.toString(),
                subtitle: RecommendTitleTextEnum.highRatedSubText.toString(),
                cafeImageUrlList: highRatedList?.map((e) => e.imageUrl[0]).toList() ?? [],
                cafeName: highRatedList?.map((e) => e.cafeName).toList() ?? [],
              ),
              Recommend(
                title: RecommendTitleTextEnum.newlyOpenedText.toString(),
                subtitle: RecommendTitleTextEnum.newlyOpenedSubText.toString(),
                cafeImageUrlList: newlyOpenedList?.map((e) => e.imageUrl[0]).toList() ?? [],
                cafeName: newlyOpenedList?.map((e) => e.cafeName).toList() ?? [],
              ),
              Recommend(
                title: RecommendTitleTextEnum.popularText.toString(),
                subtitle: RecommendTitleTextEnum.popularSubText.toString(),
                cafeImageUrlList: closestList?.map((e) => e.imageUrl[0]).toList() ?? [],
                cafeName: closestList?.map((e) => e.cafeName).toList() ?? [],
              ),
            ],
          )),
    );
  }
}
