import 'dart:async';
import 'package:hipspot/component/Webview/utils/config_navigation_delegate.dart';
import 'package:hipspot/component/Webview/utils/create_WebView_Controller.dart';
import 'package:hipspot/main.dart';
import 'package:flutter/material.dart';
import 'package:hipspot/const/channel_function_list.dart';
import 'package:hipspot/const/channel_name.dart';
import 'package:hipspot/model/trensfer_message_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  final WebViewController webViewController;
  const WebviewScreen({super.key, required this.webViewController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: webViewController),
      // floatingActionButton: TestButton(webViewController: webViewController),
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
        onPressed: () async {
          sendToWeb(TransferMessage(
              type: AppToWebFunctionList.initFilterling.name, data: "test"));
        });
  }

  Future<void> sendToWeb(TransferMessage message) async {
    return webViewController.runJavaScript(
        'window.$APP_TO_WEB_CHANNEL_NAME(${message.toJson().toString().trim()})');
  }
}
