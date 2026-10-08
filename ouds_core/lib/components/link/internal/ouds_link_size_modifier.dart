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

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Enum representing the state of the Link control.
enum OudsLinkDimensions { width, height }

class OudsLinkSizeModifier {
  final BuildContext context;

  OudsLinkSizeModifier(this.context);

  /// Retrieves the min width and min height (double) for the Link based on the provided size and density.
  Map<String, double?> getMinWidthAndHeight(
    OudsLinkSize size,
    OudsLinkDensity density,
  ) {
    final theme = OudsTheme.of(context).componentsTokens(context).link;

    if (density == OudsLinkDensity.compact) {
      return {
        OudsLinkDimensions.width.name: theme.sizeMinWidth,
        OudsLinkDimensions.height.name: theme.sizeMinHeightCompactDensity,
      };
    }

    //default density
    if (size == OudsLinkSize.small) {
      return {
        OudsLinkDimensions.width.name: theme.sizeMinWidth,
        OudsLinkDimensions.height.name: theme.sizeMinHeightSmall,
      };
    } else {
      return {
        OudsLinkDimensions.width.name: theme.sizeMinWidth,
        OudsLinkDimensions.height.name: theme.sizeMinHeightDefault,
      };
    }
  }

  /// Retrieves the width and height of icon/ chevron (double) for the Link based on the provided size enum.
  Map<String, double?> getIconSize(OudsLinkSize size) {
    final theme = OudsTheme.of(context).componentsTokens(context).link;

    if (size == OudsLinkSize.small) {
      return {
        OudsLinkDimensions.width.name: theme.sizeIconSmall,
        OudsLinkDimensions.height.name: theme.sizeIconSmall,
      };
    } else {
      return {
        OudsLinkDimensions.width.name: theme.sizeIconDefault,
        OudsLinkDimensions.height.name: theme.sizeIconDefault,
      };
    }
  }

  /// Retrieves the spaceColumnGap (double) for the Link based on the provided size enum.
  // the param layout will be removed
  double? getSizeColumnGap(
    OudsLinkSize size,
    OudsLinkLayout layout,
    OudsLinkIndicator? indicator,
    String? icon,
  ) {
    final linkToken = OudsTheme.of(context).componentsTokens(context).link;

    if (indicator == null && icon != null) {
      //textAndIcon
      return size == OudsLinkSize.small
          ? linkToken.spaceColumnGapIconSmall
          : linkToken.spaceColumnGapIconDefault;
    } else if (indicator != null) {
      return size == OudsLinkSize.small
          ? linkToken.spaceColumnGapChevronSmall
          : linkToken.spaceColumnGapChevronDefault;
    }
    switch (layout) {
      case OudsLinkLayout.textAndIcon:
        return size == OudsLinkSize.small
            ? linkToken.spaceColumnGapIconSmall
            : linkToken.spaceColumnGapIconDefault;
      case OudsLinkLayout.textOnly:
        throw UnimplementedError(
          "Error status for textOnly ColumnGap is not relevant",
        );
      case OudsLinkLayout.back:
      case OudsLinkLayout.next:
        return size == OudsLinkSize.small
            ? linkToken.spaceColumnGapChevronSmall
            : linkToken.spaceColumnGapChevronDefault;
    }
  }

  /// Retrieves the block/inline padding ([EdgeInsetsDirectional]) for the Link based on the provided size and density.
  EdgeInsetsDirectional getPadding(OudsLinkSize size, OudsLinkDensity density) {
    final linkToken = OudsTheme.of(context).componentsTokens(context).link;

    if (density == OudsLinkDensity.compact) {
      return EdgeInsetsDirectional.symmetric(
        vertical: size == OudsLinkSize.small
            ? linkToken.spacePaddingBlockCompactDensitySmall
            : linkToken.spacePaddingBlockCompactDensityDefault,
        horizontal: linkToken.spacePaddingInline,
      );
    }

    // density = Default
    if (size == OudsLinkSize.small) {
      return EdgeInsetsDirectional.symmetric(
        vertical: linkToken.spacePaddingBlockSmall,
        horizontal: linkToken.spacePaddingInline,
      );
    } else {
      return EdgeInsetsDirectional.symmetric(
        vertical: linkToken.spacePaddingBlockDefault,
        horizontal: linkToken.spacePaddingInline,
      );
    }
  }
}
