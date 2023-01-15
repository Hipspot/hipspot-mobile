import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/component/onboarding_filter_image.dart';
import 'package:hipspot/component/onboarding_filter_select.dart';
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
  void onHandleIsSelected(FilterListEnum filterListEnum, double value) {
    if (filterListEnum == selectedFilter) return;
    setState(() {
      beforeSelectedFilter = selectedFilter;
      selectedFilter = filterListEnum;

      for (var filter in FilterListEnum.values) {
        if (filter == beforeSelectedFilter || filter == selectedFilter) {
          continue;
        }
        beforeAnimateValueMap[filter] = 0;
      }
      beforeAnimateValueMap[beforeSelectedFilter] = value;
    });
  }

  double imageTopMargin(BuildContext context) {
    // 중앙 이미지 위치 계산을 위해 필요한 값
    double titleHeight = 86;
    double filterListEnumHeight = 96;
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double goButtonHeight = deviceHeight * 119 / 812;
    double emptySpace = deviceHeight -
        (titleHeight + deviceWidth + filterListEnumHeight + goButtonHeight);

    return emptySpace > 0 ? emptySpace / 2 : 0;
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
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _Title(),
                    _Skip(),
                  ],
                )),
            Container(
              height: imageTopMargin(context),
            ),
            OnboardingFilterImage(selectedFilter: selectedFilter),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 24),
                child: OnboardingFilterSelect(
                    beforeAnimateValueMap: beforeAnimateValueMap,
                    onHandleIsSelected: onHandleIsSelected,
                    selectedFilter: selectedFilter,
                    beforeSelectedFilter: beforeSelectedFilter)),
            _GoButton(
              selectedFilter: selectedFilter,
            )
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
    return Row(children: [
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
    ]);
  }
}

@immutable
class _Skip extends StatelessWidget {
  const _Skip({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
    ]);
  }
}

class _GoButton extends StatelessWidget {
  const _GoButton({super.key, required this.selectedFilter});
  final String go = "GO!";
  final double buttonHeightRatio = 119 / 812;
  final FilterListEnum selectedFilter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => {print("tapped")},
        child: Container(
            height: MediaQuery.of(context).size.height * buttonHeightRatio,
            decoration: BoxDecoration(color: selectedFilter.color),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 24, 0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(go,
                          style: TextStyle(
                              fontSize: 40,
                              color: blackColor,
                              fontFamily: FontFamily.pretendard.name,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              letterSpacing: -2)),
                      SizedBox(
                          height: 40,
                          child: Row(children: [
                            SvgPicture.asset(IconAsset.longArrow.path,
                                fit: BoxFit.none),
                          ]))
                    ]))));
  }
}
