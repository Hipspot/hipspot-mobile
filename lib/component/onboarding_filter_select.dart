import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/const/color/black_and_white_color.dart';
import 'package:hipspot/const/filter_list.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

class OnboardingFilterSelect extends StatelessWidget {
  OnboardingFilterSelect(
      {super.key,
      required this.onHandleIsSelected,
      required this.selectedFilter});

  final FilterListEnum selectedFilter;
  final Function onHandleIsSelected;

  final List<FilterListEnum> firstRow = [
    FilterListEnum.hipSpot,
    FilterListEnum.study,
    FilterListEnum.resonable
  ];
  final List<FilterListEnum> secondRow = [
    FilterListEnum.dessert,
    FilterListEnum.franchise,
    FilterListEnum.independent,
  ];

  bool checkIsSelected(FilterListEnum filterListenum) {
    return filterListenum == selectedFilter ? true : false;
  }

  Widget getFilterRow(List<FilterListEnum> filterListRow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: filterListRow
          .map((filter) => Filter(
                filterName: filter.convertName,
                isSelected: checkIsSelected(filter),
                onTap: () => onHandleIsSelected(filter),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getFilterRow(firstRow),
        const Padding(padding: EdgeInsets.only(top: 6)),
        getFilterRow(secondRow),
      ],
    );
  }
}

@immutable
class Filter extends StatelessWidget {
  Filter(
      {super.key,
      required this.filterName,
      required this.isSelected,
      required this.onTap});

  final String filterName;
  final bool isSelected;
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
      border: Border(
          bottom: BorderSide(
    color: blackColor,
    width: 2,
  )));

  final Decoration unSelectedBoxStyle = const BoxDecoration(
      border: Border(
          bottom: BorderSide(
    color: Color(0x00000000),
    width: 2,
  )));

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 26),
        child: GestureDetector(
            onTap: onTap,
            child: Container(
                decoration: isSelected ? selectedBoxStyle : unSelectedBoxStyle,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                      child: isSelected
                          ? SvgPicture.asset(IconAsset.flag.path,
                              width: 20, height: 20, color: blackColor)
                          : null),
                  const Padding(padding: EdgeInsets.only(right: 6)),
                  Text(
                    filterName,
                    style: isSelected ? selectedTextStyle : unSelectedTextStyle,
                  ),
                ]))));
  }
}
