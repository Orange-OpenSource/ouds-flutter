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

  static String get tokenVersion => "0.11.0";
}
