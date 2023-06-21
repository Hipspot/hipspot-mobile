import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hipspot/component/Webview/utils/received_message_handler.dart';
import 'package:hipspot/screen/webview_screen.dart';
import 'package:hipspot/component/login.dart';
import 'package:hipspot/screen/mypage_screen.dart';
import 'package:hipspot/screen/recommend_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../api/favorite.dart';
import '../component/Webview/utils/config_navigation_delegate.dart';
import '../component/Webview/utils/create_WebView_Controller.dart';
import '../const/channel_function_list.dart';
import '../model/trensfer_message_model.dart';

class MainScreen extends StatefulWidget {
  int? _propIndex;
  MainScreen({Key? key, int? propIndex}) : super(key: key) {
    _propIndex = propIndex;
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final storage = FlutterSecureStorage();
  final WebViewController _controller = createWebViewController()
    ..loadRequest(Uri.parse('https://hipspot.xyz/'))
    ..setNavigationDelegate(customedNavigationDelegate);
  late final Widget alivePage =
      KeepAliveWidget(child: WebviewScreen(webViewController: _controller));
  late Widget currentPage;
  late final List<Widget> _pages = [
    KeepAliveWidget(child: WebviewScreen(webViewController: _controller)),
  ];

  @override
  void initState() {
    super.initState();
    _onItemTapped(widget._propIndex ?? 0);
  }

  void setFavoriteListToWeb() async {
    if (!ReceivedMessageHandler.isWebviewInit) return;

    final response = await FavoriteApi().getList();
    if (response.statusCode == 200) {
      var fetchedData = response.data;
      var data = fetchedData['favoriteList'].map((e) => e['cafeId']).toList();

      TransferMessage message = TransferMessage(
          type: AppToWebFunctionList.setFavoriteList.name, data: data);
      ReceivedMessageHandler.sendToWeb(message, _controller);
    } else {
      print(response);
    }
  }

  void _onItemTapped(int index) async {
    print(index);
    if (index == 2) {
      String? accessToken = await storage.read(key: 'accessToken');
      String? refreshToken = await storage.read(key: 'refreshToken');

      if (accessToken == null && refreshToken == null) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              print('login창 띄우기, index=2');
              return Login(
                nextRouteWidget: MainScreen(propIndex: 2),
              );
            });
      }
    }

    setState(() {
      _selectedIndex = index;
      if (_pages.length == 2) _pages.removeAt(1);
      switch (index) {
        case 0:
          _pages[0] = alivePage;
          setFavoriteListToWeb();
          break;
        case 1:
          _pages.add(const RecommendScreen());
          break;
        case 2:
          _pages.add(const MypageScreen());
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
