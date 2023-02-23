import 'dart:convert';

import 'package:hipspot/const/channel_function_list.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReceivedMessage {
  late WebToAppFunctionsList type;
  late dynamic data;

  ReceivedMessage({required JavaScriptMessage message}) {
    Map<String, dynamic> decoded = jsonDecode(message.message);
    type = WebToAppFunctionsList.fromName(decoded['type']);
    data = decoded['data'];
  }
}
