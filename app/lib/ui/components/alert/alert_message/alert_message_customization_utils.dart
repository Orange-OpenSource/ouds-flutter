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
import 'package:ouds_core/components/alert_message/ouds_alert_message.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_message/alert_enum.dart';
import 'package:ouds_flutter_demo/ui/components/alert/alert_message/alert_message_customization.dart';
import 'package:ouds_flutter_demo/ui/theme/theme_controller.dart';
import 'package:ouds_flutter_demo/ui/utilities/app_assets.dart';
import 'package:ouds_flutter_demo/ui/utilities/component/status_enum.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Utility class for `AlertMessageCustomization`.
class AlertMessageCustomizationUtils {
  /// Returns the background color based on the alert_message message status.
  static Color getStatusColor(
    BuildContext context,
    StatusEnum enumStatus,
    bool isEnabled,
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

  /// Returns the icon status based on the alert_message message status.
  static OudsIconStatus getIconStatus(
    BuildContext context,
    AlertMessageCustomizationState customizationState,
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

  /// Maps the link action position enum to `ActionLinkPositionEnum`.
  static OudsAlertMessageActionLinkPosition getLinkActionPosition(
    ActionLinkPositionEnum position,
  ) {
    if (position == ActionLinkPositionEnum.bottom) {
      return OudsAlertMessageActionLinkPosition.bottom;
    }
    return OudsAlertMessageActionLinkPosition.topEnd;
  }
}
