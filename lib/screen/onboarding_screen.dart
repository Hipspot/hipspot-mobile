import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hipspot/component/onboarding_filter_select.dart';
import 'package:hipspot/const/color/black_and_white_color.dart';
import 'package:hipspot/const/color/filter_list_color.dart';
import 'package:hipspot/const/color/gray_scale_color.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';
import 'package:hipspot/const/path/image.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: true,
        child: Column(
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
            Expanded(
                child: Image.asset(
              ImageAsset.signBoardHipspot.path,
              fit: BoxFit.fitWidth,
            )),
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 24),
                child: OnboardingFilterSelect()),
            const _GoButton()
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
  final String go = "GO!";
  final double buttonHeightRatio = 119 / 812;
  const _GoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => {print("tapped")},
        child: Container(
            height: MediaQuery.of(context).size.height * buttonHeightRatio,
            decoration: BoxDecoration(color: pinkColor[1]),
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
                              fontWeight: FontWeight.bold,
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
