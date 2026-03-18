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

/// {@category Badge}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/badge/ouds_badge.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The status of an [OudsBadge] with an icon.
/// This status determines the icon to display.
sealed class OudsBadgeIconStatus {
  final BuildContext context;
  final String? icon;
  final OudsBadgeStatus badgeStatus;
  final Color statusColor;
  final Color iconColor;

  const OudsBadgeIconStatus({
    this.icon,
    required this.badgeStatus,
    required this.statusColor,
    required this.context,
    required this.iconColor
  });

}

/// Status for general labels without specific highlighting.
/// The icon is customizable.
class Neutral extends OudsBadgeIconStatus {
  Neutral({ super.icon, required super.context})
      : super(
      badgeStatus: OudsBadgeStatus.neutral,
      statusColor: OudsTheme.of(context).colorScheme(context).surfaceInverseHigh,
      iconColor: OudsTheme.of(context).colorScheme(context).contentInverse);
}

/// Status to highlight content related to discovery.
/// The icon is customizable.
class Accent extends OudsBadgeIconStatus {
  Accent({ super.icon, required super.context})
      : super(
      badgeStatus: OudsBadgeStatus.accent,
      statusColor: OudsTheme.of(context).colorScheme(context).surfaceStatusAccentEmphasized,
      iconColor: OudsTheme.of(context).colorScheme(context).contentOnStatusAccentEmphasized);
}

/// Indicates success, completion, or approval.
/// The icon is fixed.
class Positive extends OudsBadgeIconStatus {
  Positive({required super.context})
      : super(
      icon: AppAssets.icons.componentAlertTickConfirmationFill,
      badgeStatus: OudsBadgeStatus.positive,
      statusColor: OudsTheme.of(context).colorScheme(context).surfaceStatusPositiveEmphasized,
      iconColor: OudsTheme.of(context).colorScheme(context).contentOnStatusPositiveEmphasized
  );
}

/// Provides informational context without urgency.
/// The icon is fixed.
class Info extends OudsBadgeIconStatus {
  Info({required super.context})
      : super(
      icon: AppAssets.icons.componentAlertInformationFill,
      badgeStatus: OudsBadgeStatus.info,
      statusColor: OudsTheme.of(context).colorScheme(context).surfaceStatusInfoEmphasized,
      iconColor: OudsTheme.of(context).colorScheme(context).contentOnStatusInfoEmphasized);
}

/// Alerts the user to potential risks.
/// The icon is fixed.
class Warning extends OudsBadgeIconStatus {
  Warning({required super.context})
      : super(
    icon: AppAssets.icons.componentAlertWarningExternalShape,
    badgeStatus: OudsBadgeStatus.warning,
      statusColor: OudsTheme.of(context).colorScheme(context).surfaceStatusWarningEmphasized,
  iconColor: OudsTheme.of(context).colorScheme(context).contentOnStatusWarningEmphasized);
}

/// Draws attention to important or critical information.
/// The icon is fixed.
class Negative extends OudsBadgeIconStatus {
  Negative({required super.context})
      : super(
      icon: AppAssets.icons.componentAlertImportantFill,
      badgeStatus: OudsBadgeStatus.negative,
      statusColor: OudsTheme.of(context).colorScheme(context).surfaceStatusNegativeEmphasized,
      iconColor: OudsTheme.of(context).colorScheme(context).contentOnStatusNegativeEmphasized);
}