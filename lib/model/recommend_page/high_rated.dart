import 'dart:convert';

List<HighRated> highRatedFromJson(String str) => List<HighRated>.from(json.decode(str).map((x) => HighRated.fromJson(x)));

String highRatedToJson(List<HighRated> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HighRated {
  HighRated({
    required this.star,
    required this.review,
    required this.cafeId,
    required this.cafeName,
    required this.imageUrl,
  });

  double star;
  int review;
  String cafeId;
  String cafeName;
  List<String> imageUrl;

  factory HighRated.fromJson(Map<String, dynamic> json) => HighRated(
    star: json["star"]?.toDouble(),
    review: json["review"],
    cafeId: json["cafeId"],
    cafeName: json["cafeName"],
    imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "star": star,
    "review": review,
    "cafeId": cafeId,
    "cafeName": cafeName,
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
  };
}
