import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'ouds_accessibility_plugin_method_channel.dart';

abstract class OudsAccessibilityPluginPlatform extends PlatformInterface {
  /// Constructs a OudsAccessibilityPluginPlatform.
  OudsAccessibilityPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static OudsAccessibilityPluginPlatform _instance = MethodChannelOudsAccessibilityPlugin();

  /// The default instance of [OudsAccessibilityPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelOudsAccessibilityPlugin].
  static OudsAccessibilityPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OudsAccessibilityPluginPlatform] when
  /// they register themselves.
  static set instance(OudsAccessibilityPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isHighContrastEnabled();
}
