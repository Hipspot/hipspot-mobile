import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 추후 const로 옮기기
const APP_REDIRECT_URI = "hipspot-mobile";
const GOOGLE_AUTH_URI_BASE = 'https://api.hipspot.xyz/auth/login/google';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 343,
          height: 540,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 48),
                child: Text(
                  '즐겨찾기를 이용하려면',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff262626),
                  ),
                ),
              ),
              const Text(
                '로그인이 필요해요.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff262626),
                ),
              ),
              const SizedBox(height: 16),
              Image.asset('assets/images/mypage/join_hipspot.png'),
              const SizedBox(height: 8),
              Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: const AssetImage('assets/images/mypage/via_apple.png'),
                  width: 247,
                  height: 56,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Material(
                color: Colors.transparent,
                child: Ink.image(
                  image:
                      const AssetImage('assets/images/mypage/via_google.png'),
                  width: 247,
                  height: 56,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () async {
                      const storage = FlutterSecureStorage();

                      final result = await FlutterWebAuth.authenticate(
                        url:
                            '$GOOGLE_AUTH_URI_BASE?platform=mobile', // 쿼리 형식으로 platform=mobile 이라는 값을 전달해주면, 서버에서 스케마에 맞게 자동 리다이렉트
                        callbackUrlScheme: APP_REDIRECT_URI,
                      );
                      final accessToken =
                          Uri.parse(result).queryParameters['access_token'];

                      final refreshToken =
                          Uri.parse(result).queryParameters['refresh_token'];

                      await storage.write(
                          key: 'accessToken', value: accessToken);
                      await storage.write(
                          key: 'refreshToken', value: refreshToken);
                    },
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 48),
                  child: Text(
                    '그냥 둘러볼게요',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openLoginModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(
          child: Login(),
        );
      },
    );
  }
}
