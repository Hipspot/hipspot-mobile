import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hipspot/component/Favorite/favorite_list.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/model/favorite_card_model.dart';

import '../../component/delete_account.dart';
import '../../const/color/gray_scale_color.dart';

List<FavoriteCardModel> favoriteList = [
  FavoriteCardModel(
    title: '카페10',
    imageUrl:
        'https://hipspot.s3.ap-northeast-2.amazonaws.com/10/thumbNail.jpg',
    isBookmarked: true,
  ),
  FavoriteCardModel(
    title: '카페11',
    imageUrl:
        'https://hipspot.s3.ap-northeast-2.amazonaws.com/11/thumbNail.jpg',
    isBookmarked: true,
  ),
  FavoriteCardModel(
    title: '카페12',
    imageUrl:
        'https://hipspot.s3.ap-northeast-2.amazonaws.com/12/thumbNail.jpg',
    isBookmarked: true,
  ),
];

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
          appBar: renderAppBar(name: "황인서"),
          body: Padding(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: FavoriteList(favoriteList: favoriteList)),
        ));
  }

  PreferredSizeWidget renderAppBar({required String name}) {
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
              Text(name, style: defaultTextStyle.copyWith(fontSize: 24)),
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
                    ],
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}