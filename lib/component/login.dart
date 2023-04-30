import 'package:flutter/material.dart';

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
                  image: const AssetImage('assets/images/mypage/via_google.png'),
                  width: 247,
                  height: 56,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {},
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
}