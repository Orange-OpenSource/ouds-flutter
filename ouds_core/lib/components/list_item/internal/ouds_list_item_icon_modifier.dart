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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/common/ouds_icon_status.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/scheme/color/ouds_color_scheme.dart';

/// Modifier class that handles icon color and icon asset resolution
/// for [OudsListItem] leading and trailing icon slots based on [OudsIconStatus].
class OudsListItemIconModifier {
  final BuildContext context;

  OudsListItemIconModifier(this.context);

  /// Returns the icon color for a given [OudsIconStatus] from the provided [colorScheme].
  Color _statusIconColor(OudsIconStatus status, OudsColorScheme colorScheme) =>
      switch (status) {
        Neutral() => colorScheme.contentDefault,
        Accent() => colorScheme.contentStatusAccent,
        Positive() => colorScheme.contentStatusPositive,
        Info() => colorScheme.contentStatusInfo,
        Warning() => colorScheme.contentDefault,
        Negative() => colorScheme.contentStatusNegative,
      };

  /// Returns the fixed icon asset path for the given status.
  /// Returns `null` for [Neutral] and [Accent] where the icon is user-defined.
  String? getStatusIcon(OudsIconStatus status) => switch (status) {
    Positive() => AppAssets.icons.componentAlertTickConfirmationFill,
    Info() => AppAssets.icons.componentAlertInformationFill,
    Warning() => AppAssets.icons.componentAlertWarningExternalShape,
    Negative() => AppAssets.icons.componentAlertImportantFill,
    // Neutral and Accent icons are user-defined, not fixed.
    _ => null,
  };

  /// Returns the user-defined asset name from [Neutral] or [Accent] status.
  /// Returns `null` for all other status types whose icons are fixed.
  String? getAssetsName(OudsIconStatus? status) => switch (status) {
    Neutral(icon: final assets) => assets,
    Accent(icon: final assets) => assets,
    _ => null,
  };

  /// Builds the status icon widget for the list item leading or trailing slot.
  ///
  /// - [size] controls the rendered dimensions using token values. Defaults to
  ///   [OudsListItemIconSize.medium].
  /// - [tinted] controls whether a color filter is applied. Set to `false` to
  ///   preserve the original colors of multicolor icons.
  /// - When [enable] is `false`, all color is overridden with [contentDisabled]
  ///   so the icon appears uniformly dimmed regardless of status.
  Widget buildIcon(
    OudsIconStatus iconStatus, {
    bool enable = true,
    OudsListItemAssetSize size = OudsListItemAssetSize.medium,
    bool tinted = true,
  }) {
    return _buildIconStatus(
      iconStatus,
      enable: enable,
      size: size,
      tinted: tinted,
    );
  }

  Widget _buildIconStatus(
    OudsIconStatus status, {
    bool enable = true,
    OudsListItemAssetSize size = OudsListItemAssetSize.medium,
    bool tinted = true,
  }) {
    final nonFunctionalIcon = getAssetsName(status);
    final functionalIcon = getStatusIcon(status);
    final theme = OudsTheme.of(context);
    final listItemTokens = theme.componentsTokens(context).listItem;
    final iconTokens = theme.componentsTokens(context).icon;
    final packageName = theme.packageName;
    final colorScheme = theme.colorScheme(context);

    final iconColor = enable
        ? _statusIconColor(status, colorScheme)
        : colorScheme.contentDisabled;

    final double scaledSize = MediaQuery.textScalerOf(
      context,
    ).scale(size.value(listItemTokens));

    if (status is Warning && enable) {
      return Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.icons.componentAlertWarningExternalShape,
            excludeFromSemantics: true,
            width: scaledSize,
            height: scaledSize,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              iconTokens.colorContentStatusWarningExternalShape,
              BlendMode.srcIn,
            ),
            package: packageName,
          ),
          SvgPicture.asset(
            AppAssets.icons.componentAlertWarningInternalShape,
            excludeFromSemantics: true,
            width: scaledSize,
            height: scaledSize,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              iconTokens.colorContentStatusWarningInternalShape,
              BlendMode.srcIn,
            ),
            package: packageName,
          ),
        ],
      );
    }

    return SvgPicture.asset(
      functionalIcon ?? nonFunctionalIcon ?? '',
      matchTextDirection: nonFunctionalIcon != null,
      excludeFromSemantics: true,
      package: functionalIcon != null ? packageName : null,
      width: scaledSize,
      height: scaledSize,
      fit: BoxFit.contain,
      colorFilter: tinted ? ColorFilter.mode(iconColor, BlendMode.srcIn) : null,
    );
  }
}
