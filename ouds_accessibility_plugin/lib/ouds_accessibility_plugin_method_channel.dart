/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter plugin to get native accessibility
 * //
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'ouds_accessibility_plugin_platform_interface.dart';

/// An implementation of [OudsAccessibilityPluginPlatform] that uses method channels.
class MethodChannelOudsAccessibilityPlugin extends OudsAccessibilityPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
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
