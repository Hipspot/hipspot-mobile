enum AppToWebFunctionList {
  initFilterling('initFilterling'),
  setAuth('setAuth'),
  setMyLocation('setMyLocation'),
  setOnboardingFilter("setOnboardingFilter");

  const AppToWebFunctionList(this.name);
  final String name;
}

enum WebToAppFunctionsList {
  getMyLocation('getMyLocation'),
  getAuth('getAuth'),
  openLoginModal('openLoginModal'),
  error("ERROR"), //웹에서 보낸 메세지의 type 프로퍼티를 fromName으로 체크하는데, null인 경우
  getOnboardingFilter("getOnboardingFilter");


  const WebToAppFunctionsList(this.name);
  final String name;

  static WebToAppFunctionsList fromName(String name) {
    for (WebToAppFunctionsList enumVariant in WebToAppFunctionsList.values) {
      if (enumVariant.name == name) return enumVariant;
    }
    return WebToAppFunctionsList.error;
  }
}
