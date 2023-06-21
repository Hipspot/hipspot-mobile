import 'package:geolocator/geolocator.dart';
import 'package:hipspot/const/channel_function_list.dart';
import 'package:hipspot/const/channel_name.dart';
import 'package:hipspot/model/trensfer_message_model.dart';
import 'package:hipspot/screen/onboarding_screen.dart';
import 'package:hipspot/utils/get_my_location.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReceivedMessageHandler {
  ReceivedMessageHandler(
      {required WebToAppFunctionsList functionType, required controller}) {
    run(functionType, controller);
  }

  Future<void> run(
      WebToAppFunctionsList function, WebViewController controller) async {
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
      case WebToAppFunctionsList.getOnboardingFilter:
        {
          final onboardingFilterName = selectedFilterIndex;
          TransferMessage message = TransferMessage(
              type: AppToWebFunctionList.setOnboardingFilter.name,
              data: onboardingFilterName);
          sendToWeb(message, controller);
          return;
        }
      default:
        print("ReceivedMessageHandler default 에러");
    }
  }

  void sendToWeb(TransferMessage message, WebViewController controller) {
    controller.runJavaScript(
        'window.$APP_TO_WEB_CHANNEL_NAME(${message.toJson().toString().trim()})');
  }
}
