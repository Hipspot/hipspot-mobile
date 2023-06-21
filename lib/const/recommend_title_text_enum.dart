enum RecommendTitleTextEnum {
  closestTitle("현재 위치에서 가장 가까운 카페"),
  closestSubTitle(""),
  highRatedTitle("후기가 좋은 카페"),
  highRatedSubTitle("리뷰수와 평점을 고려했어요"),
  newlyOpenedTitle("새로 오픈한 카페"),
  newlyOpenedSubTitle(""),
  popularTitle("또 가고싶은 카페"),
  popularSubTitle("많은 유저들이 즐겨찾기한 카페");

  final String text;
  const RecommendTitleTextEnum(this.text);

  @override
  String toString() => text;
}