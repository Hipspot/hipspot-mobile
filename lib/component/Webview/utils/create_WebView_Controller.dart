import 'package:flutter/material.dart';
import 'package:hipspot/component/Webview/utils/received_message_handler.dart';
import 'package:hipspot/const/channel_name.dart';
import 'package:hipspot/model/received_message_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

WebViewController createWebViewController() {
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
  if (controller.platform is AndroidWebViewController) {
    AndroidWebViewController.enableDebugging(true);
    (controller.platform as AndroidWebViewController)
        .setMediaPlaybackRequiresUserGesture(false);
  }

  controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  controller.setBackgroundColor(const Color(0x00000000));
  controller.addJavaScriptChannel(WEB_TO_APP_CHANNEL_NAME,
      onMessageReceived: (JavaScriptMessage message) {
    ReceivedMessage parsed = ReceivedMessage(message: message);
    ReceivedMessageHandler(
        controller: controller,
        functionType: parsed.type,
        functionData: parsed.data);
  });

  return controller;
}
