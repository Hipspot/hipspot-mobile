import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hipspot/screen/webview_screen.dart';
import 'package:hipspot/component/login.dart';
import 'package:hipspot/screen/mypage_screen.dart';
import 'package:hipspot/screen/recommend_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final storage = FlutterSecureStorage();
  final Widget alivePage = KeepAliveWidget(child: WebviewScreen());
  late Widget currentPage;
  final List<Widget> _pages = [
    KeepAliveWidget(child: WebviewScreen()),
  ];

  void _onItemTapped(int index) async {
    print(index);
    if (index == 2) {
      String? accessToken = await storage.read(key: 'accessToken');
      // String? refreshToken = await storage.read(key: 'refreshToken');

      print('mainScreen click, $accessToken');
      if (accessToken == null) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Login();
            });
      }
    }

    setState(() {
      _selectedIndex = index;
      if (_pages.length == 2) _pages.removeAt(1);
      switch (index) {
        case 0:
          _pages[0] = alivePage;
          break;
        case 1:
          _pages.add(RecommendScreen());
          break;
        case 2:
          _pages.add(MypageScreen());
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottombar/map.png',
                width: 32, height: 32),
            activeIcon: Image.asset('assets/images/bottombar/map_on.png',
                width: 32, height: 32),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottombar/recommend.png',
                width: 32, height: 32),
            activeIcon: Image.asset('assets/images/bottombar/recommend_on.png',
                width: 32, height: 32),
            label: '추천',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottombar/mypage.png',
                width: 32, height: 32),
            activeIcon: Image.asset('assets/images/bottombar/mypage_on.png',
                width: 32, height: 32),
            label: '마이페이지',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
      ),
    );
  }
}

class KeepAliveWidget extends StatefulWidget {
  final Widget child;

  const KeepAliveWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Needed for AutomaticKeepAliveClientMixin
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
