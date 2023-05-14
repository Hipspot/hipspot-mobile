import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/const/path/icon.dart';

import '../../component/delete_account.dart';
import '../../component/login.dart';
import '../../const/color/gray_scale_color.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  TextStyle defaultTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontFamily: FontFamily.pretendard.name);
  bool openMenu = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: renderAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("즐겨찾기", style: defaultTextStyle.copyWith(fontSize: 20)),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 11,
                              mainAxisSpacing: 32,
                              childAspectRatio: 166 / (166 + 8 + 24)),
                      itemBuilder: (context, index) {
                        return renderBookmarkedCard(isBookmarked: true);
                      }),
                )
              ],
            ),
          ),
        ));
  }

  PreferredSizeWidget renderAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: grayScaleColor[10],
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      toolbarHeight: openMenu ? 340 : 110,
      backgroundColor: grayScaleColor[10],
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("황인서", style: defaultTextStyle.copyWith(fontSize: 24)),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: openMenu
                    ? const Icon(Icons.cancel)
                    : const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    openMenu = !openMenu;
                  });
                },
              ),
            ],
          ),
          if (openMenu)
            SizedBox(
              height: 230,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("공지사항",
                      style: defaultTextStyle.copyWith(
                          fontSize: 18, color: Colors.white)),
                  const SizedBox(height: 20),
                  Text("이용약관",
                      style: defaultTextStyle.copyWith(
                          fontSize: 18, color: Colors.white)),
                  const SizedBox(height: 20),
                  Text("개인정보 처리방침",
                      style: defaultTextStyle.copyWith(
                          fontSize: 18, color: Colors.white)),
                  const SizedBox(height: 56),
                  Row(
                    children: [
                      Text("로그아웃",
                          style: defaultTextStyle.copyWith(
                              fontSize: 16, color: const Color(0xFFCCCCCC))),
                      const SizedBox(width: 20),
                      Container(
                          width: 1, height: 16, color: const Color(0xFF404040)),
                      const SizedBox(width: 20),
                      InkWell(
                        child: Text("회원탈퇴",
                            style: defaultTextStyle.copyWith(
                                fontSize: 16, color: const Color(0xFFCCCCCC))),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DeleteAccount();
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      Container(
                          width: 1, height: 16, color: const Color(0xFF404040)),
                      const SizedBox(width: 20),
                      InkWell(
                        child: Text("Test Login",
                            style: defaultTextStyle.copyWith(
                                fontSize: 16, color: const Color(0xFFCCCCCC))),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Login();
                            },
                          );
                        },
                      ),
                      /* 로그아웃 
                      const SizedBox(width: 20),
                      Container(
                          width: 1, height: 16, color: const Color(0xFF404040)),
                      const SizedBox(width: 20),
                      InkWell(
                        child: Text("로그아웃",
                            style: defaultTextStyle.copyWith(
                                fontSize: 16, color: const Color(0xFFCCCCCC))),
                        onTap: () {
                          const storage = FlutterSecureStorage();
                          storage.deleteAll();
                        },
                      ), 
                      */
                    ],
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget renderBookmarkedCard({required bool isBookmarked}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://user-images.githubusercontent.com/24623403/226082158-34e1f2a6-5ecc-4607-83d5-0dda71c9d8a3.png")),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: isBookmarked
                        ? SvgPicture.asset(IconAsset.starFilled.path)
                        : SvgPicture.asset(IconAsset.starOutlined.path)),
              )),
        ),
        const SizedBox(height: 8),
        Text('LOOP', style: defaultTextStyle),
      ],
    );
  }
}
