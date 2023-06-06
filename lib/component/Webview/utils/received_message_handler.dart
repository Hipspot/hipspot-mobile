import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hipspot/const/channel_function_list.dart';
import 'package:hipspot/const/channel_name.dart';
import 'package:hipspot/model/trensfer_message_model.dart';
import 'package:hipspot/utils/get_my_location.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReceivedMessageHandler {
  ReceivedMessageHandler(
      {required WebToAppFunctionsList functionType,
      required controller,
      required functionData}) {
    run(functionType, functionData, controller);
  }

  Future<void> run(WebToAppFunctionsList function, data,
      WebViewController controller) async {
    switch (function) {
      case WebToAppFunctionsList.getMyLocation:
        {
          Position position = await getMyLocation();
          TransferMessage message = TransferMessage(
              type: AppToWebFunctionList.setMyLocation.name, data: position);
          sendToWeb(message, controller);
          return;
        }
      case WebToAppFunctionsList.getAuth:
        {
          print("getAuth 실행");
          return;
        }
      case WebToAppFunctionsList.openLoginModal:
        {
          print('openLoginModal 실행');
          return;
        }
      case WebToAppFunctionsList.getNotchHeight:
        {
          final devicePixelRatio =
              WidgetsBinding.instance.window.devicePixelRatio;
          final notchHeightPixel =
              WidgetsBinding.instance.window.padding.top / devicePixelRatio;
          TransferMessage message = TransferMessage(
              type: AppToWebFunctionList.setNotchHeight.name,
              data: notchHeightPixel);
          sendToWeb(message, controller);
          return;
        }
      case WebToAppFunctionsList.addFavorite:
        {
          print('addFavorite 실행');
          print(data);
          return;
        }
      case WebToAppFunctionsList.removeFavorite:
        {
          print('removeFavorite 실행');
          print(data);
          return;
        }
      case WebToAppFunctionsList.getIsWebView:
        TransferMessage message = TransferMessage(
            type: AppToWebFunctionList.setIsWebView.name, data: null);
        sendToWeb(message, controller);
        return;
      default:
        throw Error();
    }
  }

  void sendToWeb(TransferMessage message, WebViewController controller) {
    controller.runJavaScript(
        'window.$APP_TO_WEB_CHANNEL_NAME(${message.toJson().toString().trim()})');
  }
}
