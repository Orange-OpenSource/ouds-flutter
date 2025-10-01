import 'package:flutter/services.dart';
import 'package:ouds_core/plugin/ouds_accessibility_plugin_platform_interface.dart';

// An implementation of [OudsAccessibilityPluginPlatform] that uses method channels.
class MethodChannelOudsAccessibilityPlugin extends OudsAccessibilityPluginPlatform {
  // The method channel used to interact with the native platform.
  final methodChannel = const MethodChannel('ouds_accessibility_plugin');

  @override
  Future<bool> isHighContrastEnabled() async {
    try {
      final result = await methodChannel.invokeMethod<bool>('isHighTextContrastEnabled');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }
}
