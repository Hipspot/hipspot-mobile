import 'package:flutter/material.dart';
import 'package:hipspot/component/Onboarding/onboarding_filter_image.dart';
import 'package:hipspot/component/Onboarding/onboarding_filter_select.dart';
import 'package:hipspot/component/Onboarding/onboarding_go_button.dart';
import 'package:hipspot/component/Onboarding/onboarding_skip.dart';
import 'package:hipspot/component/Onboarding/onboarding_title.dart';
import 'package:hipspot/component/slide_right_route.dart';
import 'package:hipspot/const/filter_list.dart';
import 'package:hipspot/screen/main_screen.dart';

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
            const OnboardingTitle(),
            const Skip(),
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
              beforeSelectedFilter: beforeSelectedFilter,
              onTap: () => {
                Navigator.of(context).push(SlideRightRoute(page: MainScreen()))
              },
            ),
          ],
        ));
  }
}
