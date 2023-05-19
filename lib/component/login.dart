import 'package:flutter/material.dart';
import 'package:hipspot/const/auth/target_oauth.dart';
import 'package:hipspot/utils/authenticate.dart';

class Login extends StatelessWidget {
  Widget? _nextRouteWidget = null;
  Login({Key? key, Widget? nextRouteWidget}) : super(key: key) {
    _nextRouteWidget = nextRouteWidget;
    print('로그인 위젯 생성자, $_nextRouteWidget');
  }

  initState() {
    print("로그인 위젯, $_nextRouteWidget");
  }

  void _onTap(BuildContext context, TargetOauthEnum targetOauthEnum) async {
    try {
      await Authenticate.login(targetOauthEnum);
    } catch (e) {
      return print(e);
    }

    print("다음빌드위젯 $_nextRouteWidget");
    if (_nextRouteWidget != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => _nextRouteWidget!));
    }
  }

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
                      onTap: () => _onTap(context, TargetOauthEnum.apple)),
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
                      onTap: () => _onTap(context, TargetOauthEnum.google)),
                ),
              ),
              const SizedBox(height: 8),
              Material(
                color: Colors.transparent,
                child: InkWell(
                    child: const Text('dev 로그인'),
                    onTap: () => _onTap(context, TargetOauthEnum.dev)),
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
}
