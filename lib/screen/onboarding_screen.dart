import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/component/onboarding_filter_image.dart';
import 'package:hipspot/component/onboarding_filter_select.dart';
import 'package:hipspot/component/onboarding_go_button.dart';
import 'package:hipspot/const/color/black_and_white_color.dart';
import 'package:hipspot/const/color/gray_scale_color.dart';
import 'package:hipspot/const/filter_list.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // state
  FilterListEnum beforeSelectedFilter = FilterListEnum.hipSpot;
  FilterListEnum selectedFilter = FilterListEnum.hipSpot;
  double beforeSelectedValue = 0;

  Map<FilterListEnum, double> beforeAnimateValueMap = {
    FilterListEnum.hipSpot: 0,
    FilterListEnum.study: 0,
    FilterListEnum.resonable: 0,
    FilterListEnum.dessert: 0,
    FilterListEnum.franchise: 0,
    FilterListEnum.independent: 0,
  };

  // handler
  void onHandleIsSelected(FilterListEnum tappedFilter, double value) {
    if (tappedFilter == selectedFilter) return;
    setState(() {
      beforeSelectedFilter = selectedFilter;
      selectedFilter = tappedFilter;

      for (var filter in FilterListEnum.values) {
        if (filter == beforeSelectedFilter || filter == selectedFilter) {
          continue;
        }
        beforeAnimateValueMap[filter] = 0;
      }
      beforeAnimateValueMap[beforeSelectedFilter] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            const _Title(),
            const _Skip(),
            OnboardingFilterImage(
              selectedFilter: selectedFilter,
              beforeSelectedFilter: beforeSelectedFilter,
            ),
            OnboardingFilterSelect(
                beforeAnimateValueMap: beforeAnimateValueMap,
                onHandleIsSelected: onHandleIsSelected,
                selectedFilter: selectedFilter,
                beforeSelectedFilter: beforeSelectedFilter),
            GoButton(
                selectedFilter: selectedFilter,
                beforeSelectedFilter: beforeSelectedFilter),
          ],
        ));
  }
}

@immutable
class _Title extends StatelessWidget {
  final String hip = "HIP";
  final String spot = "SPOT";

  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Text(
            hip,
            style: TextStyle(
              fontFamily: FontFamily.sfPro.name,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.73,
            ),
          ),
          Text(
            spot,
            style: TextStyle(
              fontFamily: FontFamily.sfPro.name,
              fontSize: 32,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.73,
            ),
          ),
        ]));
  }
}

@immutable
class _Skip extends StatelessWidget {
  const _Skip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("어떤 카페를 찾으시나요?",
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.pretendard.name,
                fontWeight: FontWeight.w600,
              )),
          TextButton(
            child: Text('건너뛰기',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.pretendard.name,
                    fontWeight: FontWeight.w600,
                    color: grayScaleColor[5])),
            onPressed: () {
              // print('hello');
            },
          ),
        ]));
  }
}
