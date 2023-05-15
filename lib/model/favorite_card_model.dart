class FavoriteCardModel {
  final String cafeName;
  final String cafeId;
  final String thumbNail;
  final bool isBookmarked;

  FavoriteCardModel(
      {required this.cafeName,
      required this.cafeId,
      required this.thumbNail,
      required this.isBookmarked});

  factory FavoriteCardModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCardModel(
      cafeId: json['cafeId'],
      cafeName: json['cafeName'],
      thumbNail: json['thumbNail'],
      isBookmarked: json['isBookmarked'] ??= true,
    );
  }
}
