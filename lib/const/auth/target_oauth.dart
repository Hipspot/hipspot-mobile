const GOOGLE_AUTH_URI_BASE = 'https://api.hipspot.xyz/auth/login/google';
const APPLE_AUTH_URI_BASE = 'https://api.hipspot.xyz/auth/login/apple';
const DEV_AUTH_URI = 'https://api.hipspot.xyz/auth/login/dev';

enum TargetOauthEnum {
  google,
  apple,
  dev;

  String get url {
    switch (this) {
      case TargetOauthEnum.google:
        return GOOGLE_AUTH_URI_BASE;
      case TargetOauthEnum.apple:
        return APPLE_AUTH_URI_BASE;
      case TargetOauthEnum.dev:
        return DEV_AUTH_URI;
    }
  }
}
