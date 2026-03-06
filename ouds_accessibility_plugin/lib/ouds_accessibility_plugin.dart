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
import 'package:flutter/widgets.dart';

import 'ouds_accessibility_plugin_platform_interface.dart';

class OudsAccessibilityPlugin {
  // Singleton for accessing a specific platform
  static OudsAccessibilityPluginPlatform get _platform => OudsAccessibilityPluginPlatform.instance;

  /// Returns whether the High Contrast mode is enabled.
  static Future<bool> isHighContrastEnabled(BuildContext context) async {
    if (defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.iOS) {
      return MediaQuery.highContrastOf(context);
    } else {
      return await _platform.isHighContrastEnabled();
    }
  }
}
