// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/bottom_sheet/internal/ouds_bottom_sheet_constants.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Internal shared defaults for OUDS bottom sheet components.
/// @nodoc
class OudsBottomSheetDefaults {
  OudsBottomSheetDefaults._();

  /// The optional visual drag handle placed on top of a bottom sheet to
  /// indicate it may be dragged.
  ///
  /// Equivalent to `OudsBottomSheetDefaults.DragHandle()` in the OUDS design system.
  ///
  /// The drag handle total height equals [OudsBottomSheetConstants.sheetPeekHeight]
  /// (56 dp), matching the Android implementation where:
  /// `bottomPadding = SheetPeekHeight - topPadding - handleHeight`.
  static Widget dragHandle(BuildContext context) {
    final theme = OudsTheme.of(context);
    final l10n = OudsLocalizations.of(context);
    final a11yLabel = l10n?.core_bottomSheet_dragHandle_a11y ?? '';

    final double topPadding = theme.spaceScheme(context).fixedMedium;
    final double handleHeight = OudsBottomSheetConstants.handleHeight;
    final double bottomPadding =
        (OudsBottomSheetConstants.sheetPeekHeight - topPadding - handleHeight)
            .clamp(0.0, double.infinity);

    return Semantics(
      label: a11yLabel,
      button: true,
      container: true,
      value: l10n?.core_bottomSheet_hint_a11y,
      child: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: topPadding,
            bottom: bottomPadding,
          ),
          child: Container(
            width: OudsBottomSheetConstants.handleWidth,
            height: handleHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              borderRadius: BorderRadius.circular(
                OudsBottomSheetConstants.handleRadius,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
