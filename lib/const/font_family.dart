// 아이콘 이름 그대로 enum에 작성해주세요;
enum FontFamily {
  pretendard('Pretendard'),
  sfPro('SF-Pro'),
  appleSDGothicNeo("AppleSDGothicNeo");

  const FontFamily(this.name);
  final String name;
}
