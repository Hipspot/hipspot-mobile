import 'package:flutter/material.dart';

import 'package:hipspot/screen/onboarding_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      body: OnboardingScreen(),
    );
  }
}
