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

/*
class OudsSkeletonTokens {
  final OudsBorderKeyTokenRadius borderRadius;
  final OudsBorderKeyTokenWidth borderWidthDefault;
  final OudsColorKeyToken colorBgDefault;

  OudsSkeletonTokens({
    this.borderRadius = OudsBorderKeyTokenRadius.defaultRadius,
    this.borderWidthDefault = OudsBorderKeyTokenWidth.defaultWidth,
    this.colorBgDefault = OudsColorKeyToken.primary,
  });
}

 */

/// Tokens pour les skeleton dans le thème OUDS.
class OudsSkeletonTokens {
  final double borderRadius;
  final double borderWidthDefault;
  final double borderWidthDefaultInteraction;
  final double borderWidthDefaultInteractionMono;

  /// Constructeur par défaut avec des valeurs
  const OudsSkeletonTokens({
    this.borderRadius = 5, // Valeur par défaut
    this.borderWidthDefault = 3, // Valeur par défaut
    this.borderWidthDefaultInteraction = 4, // Valeur par défaut
    this.borderWidthDefaultInteractionMono = 5, // Valeur par défaut
  });
}
