//
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
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/progress_indicator/ouds_progress_indicator.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';

/// Utility methods used by OUDS progress indicators.
///
/// This class centralizes common formatting and mapping logic shared by
/// circular and linear progress indicator implementations.
class OudsProgressIndicatorUtils {
  /// Returns the [Alignment] corresponding to the helper text alignment option.
  ///
  /// This is used by the linear progress indicator to position the helper text
  /// below the component.
  static Alignment getTextAlign(
    OudsProgressIndicatorHelperTextAlignment alignment,
  ) {
    switch (alignment) {
      case OudsProgressIndicatorHelperTextAlignment.left:
        return Alignment.centerLeft;
      case OudsProgressIndicatorHelperTextAlignment.center:
        return Alignment.center;
      case OudsProgressIndicatorHelperTextAlignment.right:
        return Alignment.centerRight;
    }
  }

  /// Returns the raw progress value only when the indicator is determinate.
  ///
  /// For indeterminate indicators, returns `null` so that the underlying
  /// Flutter progress widget enters its indeterminate spinning state.
  ///
  /// > Note: the value is **not** clamped here — call [clampedProgressValue]
  /// > when a `[0.0, 1.0]` guarantee is required.
  static double? getProgressValue(
    OudsProgressIndicatorType? progressType,
    double? progress,
  ) {
    return progressType == OudsProgressIndicatorType.determinate
        ? progress
        : null;
  }

  /// Builds the helper text displayed below a linear progress indicator.
  ///
  /// - When [percentage] is `true`, the text is derived from [progress] and
  ///   formatted as a percentage (e.g. `75%` or `75 %` when
  ///   [spaceBeforePercentage] is `true`).
  /// - When [percentage] is `false`, [helperText] is returned as-is.
  /// - Returns `null` when neither condition produces content.
  static String? buildHelperText(
    bool percentage,
    bool spaceBeforePercentage,
    double? progress,
    String? helperText,
  ) {
    final progressValue = progress != null ? (progress * 100).round() : 0;
    if (percentage) {
      return spaceBeforePercentage ? '$progressValue %' : '$progressValue%';
    }

    if (helperText != null) {
      return helperText;
    }

    return null;
  }

  /// Builds the accessibility status text associated with an [OudsIconStatus].
  ///
  /// This helper returns a localized semantic label intended for assistive
  /// technologies, such as screen readers.
  static String? buildStatusSemanticsLabel(
    OudsLocalizations? localizations,
    OudsIconStatus status,
  ) {
    return status is Warning
        ? localizations?.core_common_warning_a11y
        : status is Negative
        ? localizations?.core_common_error_a11y
        : status is Info
        ? localizations?.core_common_info_a11y
        : null;
  }

  /// Returns `true` when the progress indicator should animate its value change.
  ///
  /// Animation is only active when **all three** conditions hold:
  /// 1. [progressType] is [OudsProgressIndicatorType.determinate] — indeterminate
  ///    indicators drive their own spin loop internally.
  /// 2. [animated] is `true` — the caller has explicitly requested animation.
  /// 3. The OS-level reduced-motion setting is **not** active — see
  ///    [shouldDisableAnimations] for the cross-platform detection logic.
  static bool shouldAnimate(
    OudsProgressIndicatorType? progressType,
    BuildContext context,
    bool animated,
  ) {
    final reduceMotion = shouldDisableAnimations(context);
    return progressType == OudsProgressIndicatorType.determinate &&
        animated &&
        !reduceMotion;
  }

  /// Returns `true` when the OS accessibility settings request that animations
  /// be suppressed, using the most reliable source available per platform.
  ///
  /// Two complementary checks are combined:
  ///
  /// 1. **[MediaQuery.disableAnimationsOf]** — covers Android's global
  ///    "Remove Animations" toggle (`Settings › Accessibility › Visibility
  ///    enhancements › Remove animations`) and any host app that explicitly
  ///    injects `disableAnimations: true` into its [MediaQuery].
  ///
  /// 2. **[AccessibilityFeatures.reduceMotion]** read from
  ///    `View.of(context).platformDispatcher` — covers iOS "Reduce Motion"
  ///    (`Settings › Accessibility › Motion › Reduce Motion`).
  ///    [MediaQuery.disableAnimationsOf] does **not** reliably map to
  ///    `UIAccessibility.isReduceMotionEnabled` in all Flutter versions,
  ///    so the platform dispatcher is queried directly as a fallback.
  static bool shouldDisableAnimations(BuildContext context) {
    // Android master toggle and any host-app MediaQuery override.
    if (MediaQuery.disableAnimationsOf(context)) return true;

    // iOS "Reduce Motion" — read from the platform dispatcher directly because
    // MediaQuery.disableAnimationsOf does not reliably reflect this flag on iOS.
    final accessibilityFeatures = View.of(
      context,
    ).platformDispatcher.accessibilityFeatures;
    return accessibilityFeatures.reduceMotion;
  }

  /// Builds the accessibility semantics value label for a progress indicator.
  ///
  /// Returns a localized string such as `'75 pour cent'` (FR) or `'75 percent'`
  /// (EN) when the indicator is determinate, so that VoiceOver on real iOS
  /// devices reads the value as a whole number (*"soixante-quinze pour cent"*)
  /// instead of digit-by-digit (*"sept cinq pourcent"*), which happens when the
  /// `%` symbol is used directly in the semantics value string.
  ///
  /// Returns `null` for indeterminate indicators (no meaningful value to report).
  static String? buildSemanticValueLabel(
    OudsProgressIndicatorType? progressType,
    double? progress,
    OudsLocalizations? localizations,
  ) {
    final clamped = clampedProgressValue(progressType, progress);
    if (clamped == null || localizations == null) return null;
    return localizations.core_progressIndicator_percentage_a11y(
      (clamped * 100).round(),
    );
  }

  /// Returns the normalized progress value used by the indicator.
  ///
  /// This helper delegates to [OudsProgressIndicatorUtils.getProgressValue]
  /// and ensures the resulting value is clamped between `0.0` and `1.0`.
  ///
  /// Returns `null` for indeterminate indicators.
  static double? clampedProgressValue(
    OudsProgressIndicatorType? progressType,
    double? progress,
  ) {
    return OudsProgressIndicatorUtils.getProgressValue(
      progressType,
      progress,
    )?.clamp(0.0, 1.0);
  }
}
