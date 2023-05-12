import 'dart:async';
import 'package:hipspot/component/Webview/utils/config_navigation_delegate.dart';
import 'package:hipspot/component/Webview/utils/create_WebView_Controller.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:flutter/material.dart';
import 'package:hipspot/const/channel_function_list.dart';
import 'package:hipspot/const/channel_name.dart';
import 'package:hipspot/model/trensfer_message_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({Key? key}) : super(key: key);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  int loadingProgress = 0;

  late final WebViewController _controller = createWebViewController()
    ..loadRequest(Uri.parse('https://hipspot.netlify.app/'))
    ..setNavigationDelegate(customedNavigationDelegate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
      floatingActionButton: TestButton(webViewController: _controller),
    );
  }
}

// 연결 확인용 테스트 버튼
class TestButton extends StatelessWidget {
  final WebViewController webViewController;
  const TestButton({super.key, required this.webViewController});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: const Text('test'),
        onPressed: () {
          sendToWeb(TransferMessage(
              type: AppToWebFunctionList.initFilterling.name, data: "test"));
        });
  }

  Future<void> sendToWeb(TransferMessage message) async {
    return webViewController.runJavaScript(
        'window.$APP_TO_WEB_CHANNEL_NAME(${message.toJson().toString().trim()})');
  }
}
