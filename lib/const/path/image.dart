// 이미지 이름 그대로 enum에 작성해주세요;
enum ImageAsset {
  signBoardHipspot("signboard_hipspot"),
  signboardStudy("signboard_study");

  const ImageAsset(this.name);
  final String name;
  final String pathPrifix = 'assets/images/';
  final String pathSuffix = '.png';

  String get path {
    return pathPrifix + name + pathSuffix;
  }
}
