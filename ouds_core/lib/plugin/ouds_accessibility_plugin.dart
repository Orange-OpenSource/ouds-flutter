import 'dart:io' show Platform;
import 'package:flutter/widgets.dart';
import 'package:ouds_core/plugin/ouds_accessibility_plugin_platform_interface.dart';

class OudsAccessibilityPlugin {

  // Singleton to access the platform-specific implementation.
  static OudsAccessibilityPluginPlatform get _platform =>
      OudsAccessibilityPluginPlatform.instance;

  // Returns whether the High Contrast mode is enabled based on the platform.
  static Future<bool> isHighContrastEnabled(BuildContext context) async {
    if (Platform.isMacOS || Platform.isIOS) {
      return MediaQuery.highContrastOf(context);
    } else if(Platform.isAndroid){
      return await _platform.isHighContrastEnabled();
    }
    else {
      return false;
    }
  }
}
