import 'dart:io' show Platform;
import 'package:flutter/widgets.dart';
import 'ouds_accessibility_plugin_platform_interface.dart';

class OudsAccessibilityPlugin {


  // Singleton for accessing a specific platform
  static OudsAccessibilityPluginPlatform get _platform =>
      OudsAccessibilityPluginPlatform.instance;

  // Returns whether the High Contrast mode is enabled.
  static Future<bool> isHighContrastEnabled(BuildContext context) async {
    if (Platform.isMacOS || Platform.isIOS) {
      return MediaQuery.highContrastOf(context);
    } else {
      return await _platform.isHighContrastEnabled();
    }
  }
}
