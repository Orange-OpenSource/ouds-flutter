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

abstract class OudsKeyToken {
  const OudsKeyToken();

  /// Retourne le nom qualifié de la classe sans le préfixe du package.
  String get name {
    final packageName = runtimeType.toString().split('.').first;
    return runtimeType.toString().replaceFirst('$packageName.', '');
  }
}
