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

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/ui/utilities/global_enum.dart';

/// The possible expansion states of the standard bottom sheet.
///
/// Mirrors `StandardBottomSheetDemoState.SheetValue` from the Android app.
enum BottomSheetValue { expanded, partiallyExpanded }

extension CustomElementAppearance on BottomSheetValue {
  String stringValue(BuildContext context) {
    switch (this) {
      case BottomSheetValue.expanded:
        return capitalizeEnumValue(BottomSheetValue.expanded);
      case BottomSheetValue.partiallyExpanded:
        return capitalizeEnumValue(BottomSheetValue.partiallyExpanded);
    }
  }
}
