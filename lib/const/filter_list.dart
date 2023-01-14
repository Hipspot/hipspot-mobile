enum FilterList { hipSpot, study, resonable, dessert, franchise, independent }

extension FilterListParsing on FilterList {
  String get convertName {
    switch (this) {
      case FilterList.hipSpot:
        return "힙스팟";
      case FilterList.study:
        return "스터디";
      case FilterList.resonable:
        return "가성비";
      case FilterList.dessert:
        return "디저트";
      case FilterList.franchise:
        return "프랜차이즈";
      case FilterList.independent:
        return "개인카페";
      default:
        return "";
    }
  }
}
