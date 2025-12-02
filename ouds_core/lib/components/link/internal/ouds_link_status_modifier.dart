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
import 'package:ouds_core/components/link/internal/ouds_link_control_state.dart';
import 'package:ouds_core/components/link/ouds_link.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Used to apply the right background color associated to the status
class OudsLinkStatusModifier {
  final BuildContext context;

  OudsLinkStatusModifier(this.context);

  /// Returns the text a nd icon color based on the link status.
  Color getTextAndIconColor(OudsLinkControlState state) {
    final linkTheme = OudsTheme.of(context).componentsTokens(context).link;
    final linkMonoTheme = OudsTheme.of(context).componentsTokens(context).linkMono;
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);

    switch (state) {
      case OudsLinkControlState.enabled:
        return onColoredSurface ? linkMonoTheme.colorContentEnabled : linkTheme.colorContentEnabled;
      case OudsLinkControlState.hovered:
        return onColoredSurface ? linkMonoTheme.colorContentHover : linkTheme.colorContentHover;
      case OudsLinkControlState.focused:
        return onColoredSurface ? linkMonoTheme.colorContentFocus : linkTheme.colorContentFocus;
      case OudsLinkControlState.pressed:
        return onColoredSurface ? linkMonoTheme.colorContentPressed : linkTheme.colorContentPressed;
      case OudsLinkControlState.disabled:
        return onColoredSurface ? linkMonoTheme.colorContentDisabled : OudsTheme.of(context).colorScheme(context).contentDisabled;
    }
  }

  /// Return the arrow color based on link status
  Color getArrowColor(OudsLinkControlState state) {
    final linkTheme = OudsTheme.of(context).componentsTokens(context).link;
    final linkMonoTheme = OudsTheme.of(context).componentsTokens(context).linkMono;
    final onColoredSurface = OudsTheme.isOnColoredSurfaceOf(context);

    switch (state) {
      case OudsLinkControlState.enabled:
        return onColoredSurface ? linkMonoTheme.colorContentEnabled : linkTheme.colorChevronEnabled;
      case OudsLinkControlState.hovered:
        return onColoredSurface ? linkMonoTheme.colorContentHover : linkTheme.colorChevronHover;
      case OudsLinkControlState.focused:
        return onColoredSurface ? linkMonoTheme.colorContentFocus : linkTheme.colorChevronFocus;
      case OudsLinkControlState.pressed:
        return onColoredSurface ? linkMonoTheme.colorContentPressed : linkTheme.colorChevronPressed;
      case OudsLinkControlState.disabled:
        return onColoredSurface ? linkMonoTheme.colorContentDisabled : OudsTheme.of(context).colorScheme(context).actionDisabled;
    }
  }

  /// Return the icon based on link layout
  String? getStatusIcon(OudsLinkLayout layout, bool isRtlMode) {
    switch (layout) {
      case OudsLinkLayout.textOnly:
        throw UnimplementedError("Error status for textOnly is not relevant");
      case OudsLinkLayout.textAndIcon:
        throw UnimplementedError("Error status for textAndIcon is not relevant"); // it will be implemented from user
      case OudsLinkLayout.next:
        return isRtlMode ? AppAssets.icons.componentLinkPrevious : AppAssets.icons.componentLinkNext;
      case OudsLinkLayout.back:
        return isRtlMode ? AppAssets.icons.componentLinkNext : AppAssets.icons.componentLinkPrevious;
    }
  }
}
