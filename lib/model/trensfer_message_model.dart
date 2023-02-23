class TransferMessage {
  final String type;
  final dynamic data;
  TransferMessage({required this.type, required this.data});

  Map<String, dynamic> toJson() {
    return {
      'type': getQuote(type),
      'data': getQuote(data),
    };
  }

  String getQuote(str) {
    return '"$str"';
  }
}
