import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/const/color/black_and_white_color.dart';
import 'package:hipspot/const/duration.dart';
import 'package:hipspot/const/filter_list.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

class OnboardingFilterSelect extends StatelessWidget {
  OnboardingFilterSelect(
      {super.key,
      required this.onHandleIsSelected,
      required this.selectedFilter,
      required this.beforeSelectedFilter,
      required this.beforeAnimateValueMap});

  //required
  final FilterListEnum selectedFilter;
  final FilterListEnum beforeSelectedFilter;
  final Function onHandleIsSelected;
  final Map<FilterListEnum, double> beforeAnimateValueMap;

  //row 두줄로 나누기 위해 선언
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

  Widget getFilterRowFromList(List<FilterListEnum> filterListRow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: filterListRow
          .map((filter) => Filter(
                beforeAnimateValue: beforeAnimateValueMap[filter]!,
                filterName: filter.convertName,
                isSelected: checkSelected(filter, selectedFilter),
                beforeSelected: checkSelected(filter, beforeSelectedFilter),
                onTap: (double value) => {onHandleIsSelected(filter, value)},
              ))
          .toList(),
    );
  }

  bool checkSelected(
      FilterListEnum filterListenum, FilterListEnum checkFilterListEnum) {
    return filterListenum == checkFilterListEnum ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 24),
        child: Column(
          children: [
            getFilterRowFromList(firstRow),
            const Padding(padding: EdgeInsets.only(top: 6)),
            getFilterRowFromList(secondRow),
          ],
        ));
  }
}

class Filter extends StatefulWidget {
  const Filter(
      {super.key,
      required this.beforeAnimateValue,
      required this.filterName,
      required this.isSelected,
      required this.beforeSelected,
      required this.onTap});

  final String filterName;
  final bool isSelected;
  final bool beforeSelected;
  final double beforeAnimateValue;
  final Function onTap;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: filterTextDuration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void didUpdateWidget(oldWiget) {
    super.didUpdateWidget(oldWiget);
    _controller.value = widget.beforeAnimateValue;
    if (widget.beforeSelected && widget.beforeSelected != widget.isSelected) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onTap(_animation.value),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Stack(clipBehavior: Clip.hardEdge, children: [
            _AnimatedIcon(isSelected: widget.isSelected),
            _AnimatedText(
                animation: _animation,
                isSelected: widget.isSelected,
                beforeSelected: widget.beforeSelected,
                filterName: widget.filterName),
            Container(
                child: widget.isSelected
                    ? _AnimatedUnderBar(animation: _animation)
                    : null),
          ]),
          const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0))
        ]));
  }
}

class _AnimatedIcon extends StatelessWidget {
  const _AnimatedIcon({required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        duration: filterTextDuration,
        curve: Curves.easeInQuart,
        opacity: isSelected ? 1 : 0,
        child: Container(
            padding: const EdgeInsets.only(left: 4),
            child: isSelected
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 4, 0),
                    child: SvgPicture.asset(IconAsset.flag.path,
                        width: 24, height: 26, color: blackColor))
                : null));
  }
}

class _AnimatedText extends StatelessWidget {
  const _AnimatedText(
      {required this.animation,
      required this.isSelected,
      required this.beforeSelected,
      required this.filterName});

  final Animation<double> animation;
  final bool isSelected;
  final bool beforeSelected;
  final String filterName;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Container(
            padding: EdgeInsets.fromLTRB(
                isSelected || beforeSelected ? animation.value * 30 : 0,
                0,
                6,
                2),
            child: Text(filterName,
                style: TextStyle(
                    fontFamily: FontFamily.appleSDGothicNeo.name,
                    fontSize: 26,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: blackColor))));
  }
}

class _AnimatedUnderBar extends StatelessWidget {
  const _AnimatedUnderBar({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 2,
              width: animation.value * 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle, color: blackColor),
            )));
  }
}
