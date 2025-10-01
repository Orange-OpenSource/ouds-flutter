import 'package:flutter/cupertino.dart';
import 'package:ouds_core/plugin/ouds_accessibility_plugin.dart';

class CoreAccessibility {

  /// Checks if the High Contrast mode is enabled on the device; returns a Future<bool>.
  Future<bool> isHighContrastEnabled(BuildContext context) {
    return OudsAccessibilityPlugin.isHighContrastEnabled(context);
  }
}
