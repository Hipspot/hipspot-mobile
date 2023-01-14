import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/const/color/black_and_white_color.dart';
import 'package:hipspot/const/filter_list.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

class OnboardingFilterSelect extends StatelessWidget {
  final bool isSelected;

  const OnboardingFilterSelect({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal, // 나열 방향
      alignment: WrapAlignment.start, // 정렬 방식
      spacing: 0, // 좌우 간격
      runSpacing: 6, // 상하 간격
      children: [
        for (var i in FilterList.values.map((e) => e.convertName).toList())
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: Filter(
                filterName: i,
                isSelected: isSelected,
              ))
      ],
    );
  }
}

class Filter extends StatelessWidget {
  final String filterName;
  final bool isSelected;
  Filter({super.key, required this.filterName, required this.isSelected});

  final TextStyle selectedTextStyle = TextStyle(
    fontFamily: FontFamily.appleSDGothicNeo.name,
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );
  final TextStyle unSelectedTextStyle = TextStyle(
    fontFamily: FontFamily.appleSDGothicNeo.name,
    fontSize: 26,
    fontWeight: FontWeight.w300,
  );

  final Decoration selectedBoxStyle = const BoxDecoration(
      border: Border(bottom: BorderSide(color: blackColor, width: 2)));

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: selectedBoxStyle,
        child: FittedBox(
            child: Row(children: [
          SvgPicture.asset(IconAsset.flag.path,
              width: 20, height: 20, color: blackColor),
          Text(
            filterName,
            style: isSelected ? selectedTextStyle : unSelectedTextStyle,
          )
        ])));
  }
}
