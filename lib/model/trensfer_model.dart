import 'package:hipspot/const/fromflutter_function_list.dart';

class TransferMessageModel {
  final FromFlutterFunctionList type;
  final dynamic data;
  TransferMessageModel({required this.type, required this.data});

  Map<String, dynamic> toMap() {
    return {
      'type': getQuote(type.name),
      'data': getQuote(data),
    };
  }

  String getQuote(str) {
    return '"$str"';
  }
}
