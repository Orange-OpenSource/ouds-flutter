import 'package:ouds_theme_contract/ouds_tokens_version.dart';

enum EnvironmentType { alpha, beta, prod }

class Environment {
  static Future<EnvironmentType> getCurrentEnvironment() async {
    const String flavor = String.fromEnvironment('FLAVOR');

    switch (flavor) {
      case 'alpha':
        return EnvironmentType.alpha;
      case 'beta':
        return EnvironmentType.beta;
      case 'prod':
      default:
        return EnvironmentType.prod;
    }
  }

  static String get oudsCore => OudsTokensVersion.oudsCore;
  static String get androidCore => OudsTokensVersion.androidCore;
  static String get androidSystem => OudsTokensVersion.androidSystem;
  static String get orangeCore => OudsTokensVersion.orangeCore;
  static String get orangeBrand => OudsTokensVersion.orangeBrand;
  static String get orangeCompactBrand => OudsTokensVersion.orangeCompactBrand;
  static String get soshCore => OudsTokensVersion.soshCore;
  static String get soshBrand => OudsTokensVersion.soshBrand;
  static String get wireframeCore => OudsTokensVersion.wireframeCore;
  static String get wireframeBrand => OudsTokensVersion.wireframeBrand;
}
