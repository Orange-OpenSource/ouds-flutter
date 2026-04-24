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

/// @nodoc
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Modifier class to handle color logic based on alert message and inline alert status.
class OudsAlertStatusModifier {
  final BuildContext context;

  OudsAlertStatusModifier(this.context);

  /// Returns the background color based on the alert message status.
  Color? getStatusColor(OudsIconStatus? status) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (status != null) {
      return switch (status) {
        Neutral() => colorTheme.surfaceSecondary,
        Accent() => colorTheme.surfaceStatusAccentMuted,
        Positive() => colorTheme.surfaceStatusPositiveMuted,
        Info() => colorTheme.surfaceStatusInfoMuted,
        Warning() => colorTheme.surfaceStatusWarningMuted,
        Negative() => colorTheme.surfaceStatusNegativeMuted,
      };
    }
    return null;
  }

  /// Returns the text color based on the alert message status.
  Color getStatusTextColor(OudsIconStatus? status) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (status != null) {
      return switch (status) {
        Neutral() => colorTheme.contentDefault,
        Accent() => colorTheme.contentOnStatusAccentMuted,
        Positive() => colorTheme.contentOnStatusPositiveMuted,
        Info() => colorTheme.contentOnStatusInfoMuted,
        Warning() => colorTheme.contentOnStatusWarningMuted,
        Negative() => colorTheme.contentOnStatusNegativeMuted,
      };
    }
    return colorTheme.contentDefault;
  }

  /// Returns the icon color based on the alert message status.
  Color getStatusIconColor(OudsIconStatus? status) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);

    if (status != null) {
      return switch (status) {
        Neutral() => colorTheme.contentDefault,
        Accent() => colorTheme.contentStatusAccent,
        Positive() => colorTheme.contentStatusPositive,
        Info() => colorTheme.contentStatusInfo,
        Warning() => colorTheme.contentDefault,
        Negative() => colorTheme.contentStatusNegative,
      };
    }
    return colorTheme.contentDefault;
  }

  /// Return the icon based on alert message status
  String? getStatusIcon(OudsIconStatus? status) {
    if (status != null) {
      return switch (status) {
        // For those statuses, the icon is fixed and defined here.
        Positive() => AppAssets.icons.componentAlertTickConfirmationFill,
        Info() => AppAssets.icons.componentAlertInformationFill,
        Warning() => AppAssets.icons.componentAlertWarningExternalShape,
        Negative() => AppAssets.icons.componentAlertImportantFill,

        // For the other Accent and Neutral the icon should be defined by user
        _ => null,
      };
    }
    return null;
  }

  /// Retrieve the asset name defined by user in iconStatus
  String? getAssetsName(OudsIconStatus? status) {
    if (status == null) {
      return null;
    }

    // Extract the 'icon' property only from Neutral and Accent types.
    return switch (status) {
      // If the type is Neutral or Accent, extract the 'icon' value into the 'assets' variable and return it.
      Neutral(icon: final assets) => assets,
      Accent(icon: final assets) => assets,
      // For all other status types (Positive, Info, etc.), return null
      // as their icons are fixed and not user-defined.
      _ => null,
    };
  }

  /// Builds the status icon for the alert message and inline alert.
  ///
  /// For [Warning] status, it stacks two shapes to create the icon.
  /// For other statuses, it returns a single SVG icon.
  Widget buildStatusIcon(BuildContext context, OudsIconStatus? status) {
    final statusModifier = OudsAlertStatusModifier(context);
    final nonFunctionalIcon = statusModifier.getAssetsName(status);
    final functionalIcon = statusModifier.getStatusIcon(status);
    final alertTokens = OudsTheme.of(context).componentsTokens(context).alert;

    if (status is Warning) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Background shape
          SvgPicture.asset(
            excludeFromSemantics: true,
            width: alertTokens.sizeIcon,
            height: alertTokens.sizeIcon,
            fit: BoxFit.contain,
            AppAssets.icons.componentAlertWarningExternalShape,
            colorFilter: ColorFilter.mode(
              Color(0xFFFFD000), //todo change it when PR token is merged
              BlendMode.srcIn, // Blend mode to apply the tint
            ),
            package: OudsTheme.of(context).packageName,
          ),
          // Foreground shape
          SvgPicture.asset(
            excludeFromSemantics: true,
            width: alertTokens.sizeIcon,
            height: alertTokens.sizeIcon,
            fit: BoxFit.contain,
            AppAssets.icons.componentAlertWarningInternalShape,
            colorFilter: ColorFilter.mode(
              Color(0xFF856A00), //todo change it when PR token is merged
              BlendMode.srcIn, // Blend mode to apply the tint
            ),
            package: OudsTheme.of(context).packageName,
          ),
        ],
      );
    }
    return SvgPicture.asset(
      excludeFromSemantics: true,
      functionalIcon ?? nonFunctionalIcon ?? "",
      package: functionalIcon != null
          ? OudsTheme.of(context).packageName
          : null,
      width: alertTokens.sizeIcon,
      height: alertTokens.sizeIcon,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        statusModifier.getStatusIconColor(status),
        BlendMode.srcIn,
      ),
    );
  }

  /// Inline alert text color
  Color getInlineAlertTextColor(OudsIconStatus status) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);
    switch (status) {
      case Positive():
        return colorTheme.contentStatusPositive;
      case Negative():
        return colorTheme.contentStatusNegative;
      case Warning():
        return colorTheme.contentStatusWarning;
      case Info():
        return colorTheme.contentStatusInfo;
      case Accent():
      case Neutral():
        return colorTheme.contentDefault;
    }
  }

  /// Inline alert Icon color
  Color getInlineAlertIconColor(OudsIconStatus status) {
    final colorTheme = OudsTheme.of(context).colorScheme(context);
    switch (status) {
      case Positive():
        return colorTheme.contentStatusPositive;
      case Negative():
        return colorTheme.contentStatusNegative;
      case Warning():
        return colorTheme.contentStatusWarning;
      case Info():
        return colorTheme.contentStatusInfo;
      case Accent():
        return colorTheme.contentStatusAccent;
      case Neutral():
        return colorTheme.contentDefault;
    }
  }
}
