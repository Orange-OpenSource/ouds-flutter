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
import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/alert/ouds_alert_message.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_customization.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_enum.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Utility class for `AlertCustomization`.
class AlertCustomizationUtils {
  /// Returns the background color based on the alert message status.
  static Color getAlertMessageStatusColor(
    BuildContext context,
    StatusEnum enumStatus,
  ) {
    final theme = OudsTheme.of(context).colorScheme(context);
    final status = getStatus(enumStatus);

    switch (status) {
      case Neutral():
        return theme.surfaceSecondary;
      case Accent():
        return theme.surfaceStatusAccentMuted;
      case Positive():
        return theme.surfaceStatusPositiveMuted;
      case Info():
        return theme.surfaceStatusInfoMuted;
      case Warning():
        return theme.surfaceStatusWarningMuted;
      case Negative():
        return theme.surfaceStatusNegativeMuted;
    }
  }

  /// Returns the status color based on the inline alert status.
  static Color getInlineAlertStatusColor(
    BuildContext context,
    StatusEnum enumStatus,
  ) {
    final theme = OudsTheme.of(context).colorScheme(context);
    final status = getStatus(enumStatus);

    switch (status) {
      case Neutral():
        return theme.contentDefault;
      case Accent():
        return theme.contentStatusAccent;
      case Positive():
        return theme.contentStatusPositive;
      case Info():
        return theme.contentStatusInfo;
      case Warning():
        return theme.contentStatusWarning;
      case Negative():
        return theme.contentStatusNegative;
    }
  }

  /// Returns the icon status based on the alert message status.
  static OudsIconStatus getIconStatus(
    BuildContext context,
    AlertCustomizationState customizationState,
    ThemeController themeController,
  ) {
    switch (customizationState.selectedStatus) {
      case StatusEnum.neutral:
        return Neutral(
          icon: customizationState.hasIconStatus
              ? AppAssets.icons.assistanceTipsAndTricks(themeController)
              : null,
        );
      case StatusEnum.accent:
        return Accent(
          icon: customizationState.hasIconStatus
              ? AppAssets.icons.assistanceTipsAndTricks(themeController)
              : null,
        );
      case StatusEnum.negative:
        return Negative();
      case StatusEnum.info:
        return Info();
      case StatusEnum.warning:
        return Warning();
      default:
        return Positive();
    }
  }

  /// Maps the hierarchy enum to `OudsIconStatus`.
  static OudsIconStatus getStatus(StatusEnum status) {
    switch (status) {
      case StatusEnum.neutral:
        return Neutral();
      case StatusEnum.accent:
        return Accent();
      case StatusEnum.negative:
        return Negative();
      case StatusEnum.info:
        return Info();
      case StatusEnum.warning:
        return Warning();
      default:
        return Positive();
    }
  }

  /// Maps the link action position enum to `ActionLayoutEnum`.
  static OudsAlertMessageActionLayoutEnum getActionLayout(
    ActionLayoutEnum layout,
  ) {
    if (layout == ActionLayoutEnum.bottom) {
      return OudsAlertMessageActionLayoutEnum.bottom;
    } else if (layout == ActionLayoutEnum.trailing) {
      return OudsAlertMessageActionLayoutEnum.trailing;
    } else {
      return OudsAlertMessageActionLayoutEnum.none;
    }
  }
}
