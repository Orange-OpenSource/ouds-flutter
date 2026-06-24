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
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Modifier class to handle color logic based on alert message and inline alert status.
class OudsListItemLeadingModifier {
  final BuildContext context;

  OudsListItemLeadingModifier(this.context);

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

  Widget buildTrailing(BuildContext context, OudsListItemTrailing trailing) {
    return switch (trailing) {
      // TODO: Handle this case.
      OudsListItemTrailingText() => throw UnimplementedError(),
      // TODO: Handle this case.
      OudsListItemTrailingBadge() => throw UnimplementedError(),
      // TODO: Handle this case.
      OudsListItemTrailingTag() => throw UnimplementedError(),
      // TODO: Handle this case.
      OudsListItemTrailingIcon() => throw UnimplementedError(),
      // TODO: Handle this case.
      OudsListItemTrailingImage() => throw UnimplementedError(),
      // TODO: Handle this case.
      OudsListItemTrailingFlag() => throw UnimplementedError(),
      // TODO: Handle this case.
      OudsListItemTrailingVideo() => throw UnimplementedError(),
      // TODO: Handle this case.
      OudsListItemTrailingAvatar() => throw UnimplementedError(),
    };
  }

  /// Builds the status icon for the alert message and inline alert.
  ///
  /// For [Warning] status, it stacks two shapes to create the icon.
  /// For other statuses, it returns a single SVG icon.
  Widget buildLeadingIcon(BuildContext context, OudsIconStatus iconStatus) {
    return _buildIconStatus(iconStatus);
    /*  OudsListItemLeadingImage(:final asset) => Image(image: asset),
      OudsListItemLeadingFlag(:final asset) => Image(image: asset),
      OudsListItemLeadingVideo(:final url) => Text('Video: $url'),
      OudsListItemLeadingAvatar(:final avatar) => Text('avatar'),

     */
  }

  Widget _buildIconStatus(OudsIconStatus status) {
    final nonFunctionalIcon = getAssetsName(status);
    final functionalIcon = getStatusIcon(status);
    final alertTokens = OudsTheme.of(context).componentsTokens(context).alert;
    final iconTokens = OudsTheme.of(context).componentsTokens(context).icon;

    //zoom in/out icon according to accessibility feature
    final textScaler = MediaQuery.textScalerOf(context);
    final double scaledSizeIcon = textScaler.scale(alertTokens.sizeIcon);

    if (status is Warning) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Background shape
          SvgPicture.asset(
            excludeFromSemantics: true,
            width: scaledSizeIcon,
            height: scaledSizeIcon,
            fit: BoxFit.contain,
            AppAssets.icons.componentAlertWarningExternalShape,
            colorFilter: ColorFilter.mode(
              iconTokens.colorContentStatusWarningExternalShape,
              BlendMode.srcIn, // Blend mode to apply the tint
            ),
            package: OudsTheme.of(context).packageName,
          ),
          // Foreground shape
          SvgPicture.asset(
            excludeFromSemantics: true,
            width: scaledSizeIcon,
            height: scaledSizeIcon,
            fit: BoxFit.contain,
            AppAssets.icons.componentAlertWarningInternalShape,
            colorFilter: ColorFilter.mode(
              iconTokens.colorContentStatusWarningInternalShape,
              BlendMode.srcIn, // Blend mode to apply the tint
            ),
            package: OudsTheme.of(context).packageName,
          ),
        ],
      );
    }
    return SvgPicture.asset(
      matchTextDirection: nonFunctionalIcon != null ? true : false,
      excludeFromSemantics: true,
      functionalIcon ?? nonFunctionalIcon ?? "",
      package: functionalIcon != null
          ? OudsTheme.of(context).packageName
          : null,
      width: scaledSizeIcon,
      height: scaledSizeIcon,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        getStatusIconColor(status),
        BlendMode.srcIn,
      ),
    );
  }
}
