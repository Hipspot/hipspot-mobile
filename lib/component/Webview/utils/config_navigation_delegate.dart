import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

NavigationDelegate customedNavigationDelegate = NavigationDelegate(
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
);
