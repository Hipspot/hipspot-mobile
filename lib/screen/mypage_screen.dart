import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hipspot/component/Favorite/favorite_list.dart';
import 'package:hipspot/const/font_family.dart';
import 'package:hipspot/main.dart';
import 'package:hipspot/splash_screen.dart';
import 'package:hipspot/api/user.dart';
import 'package:hipspot/utils/authenticate.dart';
import '../../component/delete_account.dart';
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
  String name = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await UserApi().get();
    print(response.data);
    setState(() {
      name = response.data['displayName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: renderAppBar(name: name),
          body: const Padding(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: FavoriteListWidget()),
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
                      InkWell(
                          child: Text("로그아웃",
                              style: defaultTextStyle.copyWith(
                                  fontSize: 16,
                                  color: const Color(0xFFCCCCCC))),
                          onTap: () async {
                            await Authenticate.logout();
                            // if (await Authenticate.logout()) {
                            //   Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               const HomeScreen()));
                            // }
                          }),
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
