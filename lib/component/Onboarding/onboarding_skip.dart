import 'package:flutter/material.dart';
import 'package:hipspot/const/color/gray_scale_color.dart';
import 'package:hipspot/const/font_family.dart';

class Skip extends StatelessWidget {
  const Skip({super.key});

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
