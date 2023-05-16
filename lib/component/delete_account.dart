import 'package:flutter/material.dart';
import 'package:hipspot/utils/api/user.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

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
                  '회원탈퇴 하시겠어요?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff262626),
                  ),
                ),
              ),
              const SizedBox(height: 19),
              const Text(
                '그동안 힙스팟을',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff737373),
                ),
              ),
              const Text(
                '이용해주셔서 감사합니다 :)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff737373),
                ),
              ),
              const SizedBox(height: 18),
              Image.asset('assets/images/mypage/exit_hipspot.png'),
              const SizedBox(height: 5),
              Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: const AssetImage('assets/images/mypage/delete_no.png'),
                  width: 247,
                  height: 56,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Material(
                color: Colors.transparent,
                child: Ink.image(
                  image:
                      const AssetImage('assets/images/mypage/delete_yes.png'),
                  width: 247,
                  height: 56,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () async {
                      await UserApi().unRegister();
                    },
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
