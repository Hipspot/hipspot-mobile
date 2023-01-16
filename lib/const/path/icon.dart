enum IconAsset {
  flag('flag'),
  longArrow('long_arrow');

  const IconAsset(this.name);
  final String name;
  final String pathPrifix = 'assets/icons/';
  final String pathSuffix = '.svg';

  String get path {
    return pathPrifix + name + pathSuffix;
  }
}
