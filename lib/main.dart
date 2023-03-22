import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hipspot/screen/onboarding_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
            extendBody: true,
            body: OnboardingScreen(),
        ),
    );
  }
}
