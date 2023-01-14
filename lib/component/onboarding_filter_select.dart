import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/const/color/black_and_white_color.dart';
import 'package:hipspot/const/filter_list.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

class OnboardingFilterSelect extends StatefulWidget {
  const OnboardingFilterSelect({super.key});

  @override
  State<OnboardingFilterSelect> createState() => _OnboardingFilterSelectState();
}

class _OnboardingFilterSelectState extends State<OnboardingFilterSelect> {
  FilterList selectedFilter = FilterList.hipSpot;

  bool checkIsSelected(FilterList filterList) {
    return filterList == selectedFilter ? true : false;
  }

  List<FilterList> firstRow = [
    FilterList.hipSpot,
    FilterList.study,
    FilterList.resonable
  ];
  List<FilterList> secondRow = [
    FilterList.dessert,
    FilterList.franchise,
    FilterList.independent,
  ];

  Widget getFilterRow(List<FilterList> filterInList) {
    return Row(
      children: filterInList
          .map((filter) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: Filter(
                filterName: filter.convertName,
                isSelected: checkIsSelected(filter),
                onTap: () => onHandleIsSelected(filter),
              )))
          .toList(),
    );
  }

  void onHandleIsSelected(FilterList filterList) {
    setState(() {
      selectedFilter = filterList;
    });
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
    return Container(
        decoration: isSelected ? selectedBoxStyle : unSelectedBoxStyle,
        child: GestureDetector(
            onTap: onTap,
            child: FittedBox(
                child: Row(children: [
              Container(
                  child: isSelected
                      ? SvgPicture.asset(IconAsset.flag.path,
                          width: 20, height: 20, color: blackColor)
                      : null),
              const Padding(padding: EdgeInsets.only(right: 1)),
              Text(
                filterName,
                style: isSelected ? selectedTextStyle : unSelectedTextStyle,
              )
            ]))));
  }
}
