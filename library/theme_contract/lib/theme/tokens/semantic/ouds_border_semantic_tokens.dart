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

import 'package:global_raw_tokens/border_raw_tokens.dart';

/// Classe pour les tokens sémantiques de bordure.
class OudsBorderSemanticTokens {
  /// Largeurs de bordure
  static const double defaultBorderWidth = BorderRawTokens.borderWidth25;
  static const double mediumBorderWidth = BorderRawTokens.borderWidth50;
  static const double thickBorderWidth = BorderRawTokens.borderWidth75;

  /// Rayons de bordure
  static const double defaultBorderRadius = BorderRawTokens.borderRadius0;
  static const double mediumBorderRadius = BorderRawTokens.borderRadius150;
  static const double noneBorderRadius = BorderRawTokens.borderRadius0;
  static const double pillBorderRadius = BorderRawTokens.borderRadius9999;
  static const double shortBorderRadius = BorderRawTokens.borderRadius75;
  static const double tallBorderRadius = BorderRawTokens.borderRadius300;

  /// Styles de bordure
  static const String defaultBorderStyle = BorderRawTokens.borderStyleSolid;
  static const String dragBorderStyle = BorderRawTokens.borderStyleDashed;
}
