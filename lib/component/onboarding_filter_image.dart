import 'package:flutter/material.dart';
import 'package:hipspot/const/filter_list.dart';

class OnboardingFilterImage extends StatelessWidget {
  const OnboardingFilterImage({super.key, required this.selectedFilter});
  final FilterListEnum selectedFilter;

  //그림자 포함한 이미지 너비(400) 대 원 지름(340) 비율 계산
  final double circleWidthRatioAgainstImage = 340 / 400;

  //context에서 기기 넓이 조회
  double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  //이미지 너비로 원 지름 계산
  double diameter(BuildContext context) {
    return deviceWidth(context) * circleWidthRatioAgainstImage;
  }

  //원 Left margin값 계산
  double leftMargin(BuildContext context) {
    double contextWidth = deviceWidth(context);
    double circleWidth = diameter(context);
    return (contextWidth - circleWidth) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            constraints: BoxConstraints(
                //signboard 이미지 Stack에 구현, 디바이스 Width에 맞춰 고정
                minWidth: deviceWidth(context),
                maxHeight: deviceWidth(context)),
            child: Stack(clipBehavior: Clip.none, children: [
              Positioned(
                  left: leftMargin(context),
                  child: Container(
                      width: diameter(context),
                      height: diameter(context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedFilter.color))),
              Positioned(
                  top: 0,
                  child: Image.asset(selectedFilter.filterImageString,
                      width: deviceWidth(context), fit: BoxFit.fitWidth)),
            ])));
  }
}
