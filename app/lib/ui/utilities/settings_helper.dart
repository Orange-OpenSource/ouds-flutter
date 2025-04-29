/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';

class SettingsHelper {
  static const MethodChannel _channel = MethodChannel('app.channel.shared.data');

  static Future<void> openAppropriateSettings() async {
    if (Platform.isIOS) {
      AppSettings.openAppSettings();
    } else if (Platform.isAndroid) {
      try {
        await _channel.invokeMethod('openLanguageSettings');
      } on PlatformException catch (e) {
        debugPrint("Error opening Android language settings: ${e.message}");
      }
    }
  }
}
