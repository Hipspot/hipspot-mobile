import 'package:flutter/material.dart';
import 'package:hipspot/const/font_family.dart';

class OnboardingTitle extends StatelessWidget {
  final String hip = "HIP";
  final String spot = "SPOT";

  const OnboardingTitle({super.key});

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
