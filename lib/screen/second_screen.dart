import 'package:flutter/material.dart';
import 'package:hipspot/component/Webview/webview.dart';
import 'package:hipspot/screen/pages/mypage_screen.dart';
import 'package:hipspot/screen/pages/recommend_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          Webview(),
          RecommendScreen(),
          MypageScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottombar/map.png', width: 32, height: 32),
            activeIcon: Image.asset('assets/images/bottombar/map_on.png', width: 32, height: 32),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottombar/recommend.png', width: 32, height: 32),
            activeIcon: Image.asset('assets/images/bottombar/recommend_on.png', width: 32, height: 32),
            label: '추천',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/bottombar/mypage.png', width: 32, height: 32),
            activeIcon: Image.asset('assets/images/bottombar/mypage_on.png', width: 32, height: 32),
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
