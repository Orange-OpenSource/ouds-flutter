/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 * //
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 * //
 * // Software description: Flutter library of reusable graphical components
 * //
 */

/// {@category List item}
library;

import 'package:flutter/foundation.dart';

@immutable
class OudsListItemData {
  final String label;
  final bool isBoldLabel;
  final String? description;
  final String? overline;
  final String? extraLabel;
  final String? helperText;

  const OudsListItemData({
    required this.label,
    this.isBoldLabel = false,
    this.description,
    this.overline,
    this.extraLabel,
    this.helperText,
  });
}
