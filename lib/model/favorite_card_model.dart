class FavoriteCardModel {
  final String title;
  final String imageUrl;
  final bool isBookmarked;

  FavoriteCardModel(
      {required this.title,
      required this.imageUrl,
      required this.isBookmarked});

  factory FavoriteCardModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCardModel(
      title: json['cafeName'],
      imageUrl: json['thumbNail'],
      isBookmarked: true,
    );
  }
}
