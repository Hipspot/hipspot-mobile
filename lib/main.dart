import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:hipspot/component/login.dart';
import 'package:hipspot/splash_screen.dart';
import 'package:hipspot/utils/dio/dio_interceptor.dart';

final dio = Dio();
late BuildContext context;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  dio.interceptors.add(DioOnRequestInterceptor());
  dio.interceptors.add(DioOnErrorInterceptor());
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(context);
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

void showLoginModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Login(),
  );
}
