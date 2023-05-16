import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:hipspot/splash_screen.dart';
import 'package:hipspot/utils/api/interceptor/dio_interceptor.dart';
import 'package:path_provider/path_provider.dart';

final dio = Dio();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Get the application documents directory.
  var dir = await getApplicationDocumentsDirectory();
  // Create a FileStorage with the directory.
  var storage = FileStorage(dir.path);
  // Create a PersistCookieJar with the directory.
  var cj = PersistCookieJar(storage: storage);
  dio.interceptors.add(CookieManager(cj));
  dio.interceptors.add(DioAddQueryInterceptor());
  dio.interceptors.add(DioUnAuthErrorInterceptor());
  cj.deleteAll();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
