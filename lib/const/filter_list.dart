import 'package:flutter/material.dart';
import 'package:hipspot/const/color/filter_list_color.dart';
import 'package:hipspot/const/path/image.dart';

enum FilterListEnum {
  hipSpot,
  study,
  resonable,
  dessert,
  franchise,
  independent
}

extension FilterListEnumParsing on FilterListEnum {
  String get convertName {
    switch (this) {
      case FilterListEnum.hipSpot:
        return "힙스팟";
      case FilterListEnum.study:
        return "스터디";
      case FilterListEnum.resonable:
        return "가성비";
      case FilterListEnum.dessert:
        return "디저트";
      case FilterListEnum.franchise:
        return "프랜차이즈";
      case FilterListEnum.independent:
        return "개인카페";
      default:
        return "";
    }
  }

  Color get color {
    switch (this) {
      case FilterListEnum.hipSpot:
        return pinkColor[1]!;
      case FilterListEnum.study:
        return greenColor[1]!;
      case FilterListEnum.resonable:
        return yellowColor[1]!;
      case FilterListEnum.dessert:
        return brownColor[1]!;
      case FilterListEnum.franchise:
        return blueColor[1]!;
      case FilterListEnum.independent:
        return violetColor[1]!;
    }
  }

// svg 제작 후 수정 필요
  String get filterImageString {
    switch (this) {
      case FilterListEnum.hipSpot:
        return SignboardImage.hipspot.path;
      case FilterListEnum.study:
        return SignboardImage.study.path;
      case FilterListEnum.resonable:
        return SignboardImage.resonable.path;
      case FilterListEnum.dessert:
        return SignboardImage.dessert.path;
      case FilterListEnum.franchise:
        return SignboardImage.franchise.path;
      case FilterListEnum.independent:
        return SignboardImage.independent.path;
      default:
        return "";
    }
  }
}
