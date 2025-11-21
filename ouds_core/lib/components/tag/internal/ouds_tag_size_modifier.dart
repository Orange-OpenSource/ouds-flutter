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

import 'package:flutter/cupertino.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Enum representing the state of the tag control.
enum OudsTagDimensions {
  width,
  height,
}

class OudsTagSizeModifier {
  final BuildContext context;

  OudsTagSizeModifier(this.context);

  /// Retrieves the min width and min height (double) for the tag based on the provided size enum.
  Map<String, double?> getMinWidthAndHeight(OudsTagSize? size) {
    final theme = OudsTheme.of(context).componentsTokens(context).tag;

    if (size == OudsTagSize.small) {
      return {OudsTagDimensions.width.name: theme.sizeMinWidthSmall, OudsTagDimensions.height.name: theme.sizeMinHeightSmall};
    } else {
      return {OudsTagDimensions.width.name: theme.sizeMinWidthDefault, OudsTagDimensions.height.name: theme.sizeMinHeightDefault};
    }
  }

  /// Retrieves the width and height of icon (double) for the tag based on the provided size enum.
  Map<String, double?> getAssetsSize(OudsTagSize? size) {
    final theme = OudsTheme.of(context).componentsTokens(context).tag;

    if (size == OudsTagSize.small) {
      return {OudsTagDimensions.width.name: theme.sizeAssetSmall, OudsTagDimensions.height.name: theme.sizeAssetSmall};
    } else {
      return {OudsTagDimensions.width.name: theme.sizeAssetDefault, OudsTagDimensions.height.name: theme.sizeAssetDefault};
    }
  }

  /// Retrieves the padding (EdgeInsetsDirectional) for the tag based on the provided size enum.
  EdgeInsetsDirectional getPadding(OudsTagSize? size, bool isIcon) {
    final theme = OudsTheme.of(context).componentsTokens(context).tag;

    if (!isIcon) {
      if (size == OudsTagSize.small) {
        return EdgeInsetsDirectional.symmetric(
          vertical: theme.spacePaddingBlockSmall,
          horizontal: theme.spacePaddingInlineSmall,
        );
      } else {
        return EdgeInsetsDirectional.symmetric(
          vertical: theme.spacePaddingBlockDefault,
          horizontal: theme.spacePaddingInlineDefault,
        );
      }
    } else {
      if (size == OudsTagSize.small) {
        return EdgeInsetsDirectional.only(top: theme.spacePaddingBlockSmall, start: theme.spacePaddingInlineAssetSmall, bottom: theme.spacePaddingBlockSmall, end: theme.spacePaddingInlineSmall);
      } else {
        return EdgeInsetsDirectional.only(top: theme.spacePaddingBlockDefault, start: theme.spacePaddingInlineAssetDefault, bottom: theme.spacePaddingBlockDefault, end: theme.spacePaddingInlineDefault);
      }
    }
  }

  /// Retrieves the spaceColumnGap (double) for the tag based on the provided size enum.
  double? getSizeColumnGap(OudsTagSize? size) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

    return size == OudsTagSize.small ? tagToken.spaceColumnGapSmall : tagToken.spaceColumnGapDefault;
  }

  /// Retrieves the padding (EdgeInsetsGeometry) for the loading assets state based on the provided size enum.
  EdgeInsetsGeometry getLoadingAssetsPadding(OudsTagSize? size){
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;
    return EdgeInsetsGeometry.all(
        size != null && size == OudsTagSize.small
        ? tagToken.spaceInsetLoaderSmall
        : tagToken.spaceInsetLoaderDefault
    );

  }

  /// Retrieves the padding (EdgeInsetsGeometry) for the assets based on the provided size enum.
  EdgeInsetsGeometry getAssetsPadding(OudsTagSize? size, OudsTagLayout layout) {
    final tagToken = OudsTheme.of(context).componentsTokens(context).tag;

    switch (layout) {
      case OudsTagLayout.textAndIcon:
        return EdgeInsetsGeometry.all(size != null && size == OudsTagSize.small ? tagToken.spaceInsetIconSmall : tagToken.spaceInsetIconDefault);
      case OudsTagLayout.textAndBullet:
        return EdgeInsetsGeometry.all(size != null && size == OudsTagSize.small ? tagToken.spaceInsetBulletSmall : tagToken.spaceInsetBulletDefault);
        case OudsTagLayout.textOnly:
        return EdgeInsetsGeometry.all(OudsTheme.of(context).borderTokens.radiusNone);
    }
  }
}
