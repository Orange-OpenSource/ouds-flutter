// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components

/// {@category Flag}
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Base dimensions of a flag (logical pixels, before text-scale is applied).
const double _kFlagBaseWidth = 67.0;
const double _kFlagBaseHeight = 50.0;

/// A UI element that displays a country or region flag identified by its
/// ISO 3166-1 alpha-2 [countryCode].
///
/// ### Purpose
/// The flag is **purely decorative** — it identifies a country or region
/// visually and must never serve as a functional indicator (e.g. it must
/// not represent a language choice).
///
/// ### Size
/// A flag always renders at **67 × 50 dp** (base dimensions).
/// These values are **not fixed** during user zoom: they are multiplied by
/// the system text scale factor so the flag grows proportionally with the
/// user's zoom level — in compliance with OUDS accessibility guidelines.
///
/// ### Assets
/// SVG flag assets are bundled inside `ouds_core` under
/// `assets/flags/<code>.svg` (e.g. `assets/flags/fr.svg`).
/// The [countryCode] is case-insensitive — `'FR'` and `'fr'` both resolve
/// to the French flag. An unknown code renders an empty space of the
/// correct scaled size.
///
/// ### Semantics
/// Flags are always excluded from the accessibility tree (decorative).
/// The country name must be provided through a sibling text label in the UI
/// (e.g. the [OudsListItem.label] next to the flag).
///
/// Example:
/// ```dart
/// OudsFlag('fr')
/// OudsFlag('US')   // case-insensitive
/// ```
///
/// Example — inside a list item:
/// ```dart
/// OudsListItem(
///   label: 'France',                              // country name in the label
///   leading: OudsListItemLeadingFlag(OudsFlag('fr')),
/// )
/// ```
class OudsFlag extends StatelessWidget {
  /// ISO 3166-1 alpha-2 country code (case-insensitive).
  ///
  /// Examples: `'fr'`, `'FR'`, `'us'`, `'gb'`.
  final String countryCode;

  const OudsFlag(this.countryCode, {super.key});

  @override
  Widget build(BuildContext context) {
    // Scale the base dimensions with the system text scaler so the flag
    // grows proportionally when the user increases their zoom level.
    // This fulfils the OUDS accessibility requirement: flag resizing
    // must never be blocked.
    final textScaler = MediaQuery.textScalerOf(context);
    final scaledWidth = textScaler.scale(_kFlagBaseWidth);
    final scaledHeight = textScaler.scale(_kFlagBaseHeight);

    // Flags are purely decorative — always excluded from the semantics tree.
    // The country name must be communicated through a sibling text element.
    return ExcludeSemantics(
      child: ClipRRect(
        // Rounded corners ensure the flag is visually contained regardless
        // of the surrounding background or the flag's own shape.
        borderRadius: BorderRadius.circular(2),
        child: SvgPicture.asset(
          'assets/flags/${countryCode.toLowerCase()}.svg',
          width: scaledWidth,
          height: scaledHeight,
          fit: BoxFit.cover,
          // Must specify the package so Flutter resolves the asset from
          // ouds_core instead of the consuming application.
          package: 'ouds_core',
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}
