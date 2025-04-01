import 'package:package_info_plus/package_info_plus.dart';

enum EnvironmentType { alpha, beta, production }

class Environment {
  static Future<EnvironmentType> getCurrentEnvironment() async {
    final packageInfo = await PackageInfo.fromPlatform();

    switch (packageInfo.packageName) {
      case "com.orange.ouds.flutterapp":
        return EnvironmentType.production;
      case "com.orange.ouds.alpha.flutterapp":
        return EnvironmentType.alpha;
      case "com.orange.ouds.beta.flutterapp":
        return EnvironmentType.beta;
      default:
        return EnvironmentType.production;
    }
  }
}
