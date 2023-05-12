import 'dart:convert';

List<NewlyOpened> newlyOpenedFromJson(String str) => List<NewlyOpened>.from(json.decode(str).map((x) => NewlyOpened.fromJson(x)));

String newlyOpenedToJson(List<NewlyOpened> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewlyOpened {
  String cafeId;
  String cafeName;
  double distance;
  double duration;
  List<String> imageUrl;

  NewlyOpened({
    required this.cafeId,
    required this.cafeName,
    required this.distance,
    required this.duration,
    required this.imageUrl,
  });

  factory NewlyOpened.fromJson(Map<String, dynamic> json) => NewlyOpened(
    cafeId: json["cafeId"],
    cafeName: json["cafeName"],
    distance: json["distance"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
    imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "cafeId": cafeId,
    "cafeName": cafeName,
    "distance": distance,
    "duration": duration,
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
  };
}
