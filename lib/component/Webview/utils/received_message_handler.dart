import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hipspot/const/channel_function_list.dart';
import 'package:hipspot/const/channel_name.dart';
import 'package:hipspot/model/trensfer_message_model.dart';
import 'package:hipspot/utils/get_my_location.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../api/favorite.dart';

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
          await FavoriteApi().add(data);
          final response = await FavoriteApi().getList();
          if (response.statusCode == 200) {
            var fetchedData = response.data;
            data = fetchedData['favoriteList'].map((e) => e['cafeId']).toList();
            TransferMessage message = TransferMessage(
                type: AppToWebFunctionList.setFavoriteList.name, data: data);
            sendToWeb(message, controller);
          } else {
            print(response);
          }
          return;
        }
      case WebToAppFunctionsList.removeFavorite:
        {
          await FavoriteApi().remove(data);
          final response = await FavoriteApi().getList();
          if (response.statusCode == 200) {
            var fetchedData = response.data;
            data = fetchedData['favoriteList'].map((e) => e['cafeId']).toList();
            TransferMessage message = TransferMessage(
                type: AppToWebFunctionList.setFavoriteList.name, data: data);
            sendToWeb(message, controller);
          } else {
            print(response);
          }
          return;
        }
      case WebToAppFunctionsList.getIsWebView:
        isWebviewInit = true;
        TransferMessage message = TransferMessage(
            type: AppToWebFunctionList.setIsWebView.name, data: null);
        sendToWeb(message, controller);
        return;
      case WebToAppFunctionsList.getFavoriteList:
        final response = await FavoriteApi().getList();
        if (response.statusCode == 200) {
          var fetchedData = response.data;
          data = fetchedData['favoriteList'].map((e) => e['cafeId']).toList();
          TransferMessage message = TransferMessage(
              type: AppToWebFunctionList.setFavoriteList.name, data: data);
          sendToWeb(message, controller);
        } else {
          print(response);
        }
        return;

      default:
        throw Error();
    }
  }

  static void sendToWeb(TransferMessage message, WebViewController controller) {
    controller.runJavaScript(
        'window.$APP_TO_WEB_CHANNEL_NAME(${message.toJson().toString().trim()})');
  }

  static bool isWebviewInit = false;
}
