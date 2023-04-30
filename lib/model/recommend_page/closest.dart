import 'dart:convert';

List<Closest> closestFromJson(String str) => List<Closest>.from(json.decode(str).map((x) => Closest.fromJson(x)));

String closestToJson(List<Closest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Closest {
  Closest({
    required this.cafeId,
    required this.cafeName,
    required this.distance,
    required this.duration,
    required this.imageUrl,
  });

  String cafeId;
  String cafeName;
  double distance;
  double duration;
  List<String> imageUrl;

  factory Closest.fromJson(Map<String, dynamic> json) => Closest(
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
