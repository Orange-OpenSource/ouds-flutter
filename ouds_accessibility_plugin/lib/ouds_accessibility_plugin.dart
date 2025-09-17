import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'ouds_accessibility_plugin_platform_interface.dart';

class OudsAccessibilityPlugin {


  /// Singleton pour accéder à la plateforme spécifique
  static OudsAccessibilityPluginPlatform get _platform =>
      OudsAccessibilityPluginPlatform.instance;

  /// Retourne si le mode High Contrast est activé
  static Future<bool> isHighContrastEnabled(BuildContext context) async {
    if (Platform.isMacOS || Platform.isIOS) {
      return MediaQuery.highContrastOf(context);
    } else {
      return await _platform.isHighContrastEnabled();
    }
  }
}
