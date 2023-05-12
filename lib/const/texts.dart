enum Texts {
  closestText("현재 위치에서 가장 가까운 카페"),
  closestSubText(""),
  highRatedText("후기가 좋은 카페"),
  highRatedSubText("리뷰수와 평점을 고려했어요"),
  newlyOpenedText("새로 오픈한 카페"),
  newlyOpenedSubText(""),
  popularText("또 가고싶은 카페"),
  popularSubText("많은 유저들이 즐겨찾기한 카페");

  final String text;
  const Texts(this.text);

  @override
  String toString() => text;
}