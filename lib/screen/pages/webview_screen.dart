import 'dart:async';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hipspot/const/fromflutter_function_list.dart';
import 'package:hipspot/const/js_channel_name.dart';
import 'package:hipspot/model/trensfer_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({Key? key}) : super(key: key);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  WebViewController ?createWebViewController() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
// ···
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    return null;
  }


  // Preparation for the webview
  int loadingProgress = 0;

  late final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..addJavaScriptChannel('fromflutterMessageHandler',
        onMessageReceived: (JavaScriptMessage message) {
      print(message.message);
    })
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://hipspot.netlify.app/'));

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

  Future<void> sendToWeb(TransferMessageModel message) {
    return webViewController.runJavaScript(
        'window.$JS_CHANNEL_NAME(${message.toMap().toString().trim()})');
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: const Text('test'),
        onPressed: () {
          sendToWeb(TransferMessageModel(
              type: FromFlutterFunctionList.initFilterling, data: "test"));
        });
  }
}
