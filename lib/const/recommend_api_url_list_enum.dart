enum RecommendApiUrlListEnum {
  closestApi("https://api.hipspot.xyz/cafe/recommend/nearby?"),
  highRatedApi("https://api.hipspot.xyz/cafe/recommend/high-rated"),
  newlyOpenedApi("https://api.hipspot.xyz/cafe/recommend/new?");

  final String url;
  const RecommendApiUrlListEnum(this.url);

  @override
  String toString() => url;
}