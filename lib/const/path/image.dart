// 이미지 이름 그대로 enum에 작성해주세요;
enum SignboardImage {
  hipspot("signboard/hipspot"),
  study("signboard/study"),
  resonable("signboard/resonable"),
  franchise("signboard/franchise"),
  dessert("signboard/dessert"),
  independent("signboard/independent");

  const SignboardImage(this.name);
  final String name;
  final String pathPrifix = 'assets/images/';
  final String pathSuffix = '.png';

  String get path {
    return pathPrifix + name + pathSuffix;
  }
}
