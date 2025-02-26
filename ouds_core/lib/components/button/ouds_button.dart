/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:ouds_core/ouds_theme.dart';

/// [OUDS Button design guidelines](https://unified-design-system.orange.com/472794e18/p/48a788-button)
///
/// An OUDS button which displays text only.
///
/// In the case it is used in an [OudsColoredBox], its monochrome variant is automatically displayed.
/// Some tokens associated with these specific colors can be customized and are identified with the `Mono` suffix (for instance [OudsButtonTokens.colorBgDefaultEnabledMono]).
///
/// **Parameters**:
/// - `text`: Text displayed in the button.
/// - `onClick`: Callback invoked when the button is clicked.
/// - `enabled`: Controls the enabled state of the button when [style] is equal to [OudsButton.Style.Default].
///   When `false`, this button will not be clickable. Has no effect when [style] is equal to [OudsButton.Style.Loading].
/// - `style`: The button style.
/// - `hierarchy`: The button hierarchy.
///   A button with [OudsButton.Hierarchy.Negative] hierarchy is not allowed as a direct or indirect child of an [OudsColoredBox] and will throw an [IllegalStateException].
///
/// **Samples**:
/// - [OudsButtonWithTextSample](com.orange.ouds.core.component.samples.OudsButtonWithTextSample)
/// - [OudsButtonWithTextOnColoredBackgroundSample](com.orange.ouds.core.component.samples.OudsButtonWithTextOnColoredBackgroundSample)

class OudsButton extends StatelessWidget {
  /// The button's title displayed inside the button.
  final String? label;

  /// The action to be executed when the button is pressed.
  final Function()? onClick;

  /// The optional button's icon.
  final Widget? icon;

  const OudsButton({
    super.key,
    this.label,
    this.icon,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = OudsTheme.of(context);

    /// Icon only
    if (icon != null && label == null) {
      return IconButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: theme.componentsTokens.button.colorBgDefaultEnabled,
          textStyle: TextStyle(
              fontSize: theme.fontTokens.sizeLabelLarge, fontWeight: FontWeight.w700, letterSpacing: theme.fontTokens.letterSpacingLabelLarge),
          side: BorderSide(
            color:
                onClick != null ? theme.componentsTokens.button.colorBorderDefaultEnabled : theme.componentsTokens.button.colorBorderDefaultDisabled,
            width: theme.componentsTokens.button.borderWidthDefault,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.componentsTokens.button.borderRadius),
          ),
          padding: EdgeInsets.all(theme.componentsTokens.button.spaceInsetIconOnly),
          minimumSize: Size(theme.componentsTokens.button.sizeMinWidth, theme.componentsTokens.button.sizeMinHeight),
        ),
        visualDensity: VisualDensity.standard,
        icon: icon!,
        onPressed: onClick,
      );
    }

    /// Icon + Text
    if (icon != null && label != null) {
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: theme.componentsTokens.button.colorBgDefaultEnabled,
          textStyle: TextStyle(
              fontSize: theme.fontTokens.sizeLabelLarge, fontWeight: FontWeight.w700, letterSpacing: theme.fontTokens.letterSpacingLabelLarge),
          side: BorderSide(
            color:
                onClick != null ? theme.componentsTokens.button.colorBorderDefaultEnabled : theme.componentsTokens.button.colorBorderDefaultDisabled,
            width: theme.componentsTokens.button.borderWidthDefault,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.componentsTokens.button.borderRadius),
          ),
          padding: EdgeInsets.only(
            top: theme.componentsTokens.button.spacePaddingBlock,
            right: theme.componentsTokens.button.spacePaddingInlineEndIconStart,
            bottom: theme.componentsTokens.button.spacePaddingBlock,
            left: theme.componentsTokens.button.spacePaddingInlineIconStart,
          ),
          minimumSize: Size(theme.componentsTokens.button.sizeMinWidth, theme.componentsTokens.button.sizeMinHeight),
        ),
        onPressed: onClick,
        icon: icon,
        iconAlignment: IconAlignment.start,
        label: Text(
          label!,
          style: TextStyle(
            color: onClick != null
                ? theme.componentsTokens.button.colorContentDefaultEnabled
                : theme.componentsTokens.button.colorContentDefaultDisabled,
          ),
        ),
      );
    }

    /// Text Only
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: theme.componentsTokens.button.colorBgDefaultEnabled,
        textStyle: TextStyle(
            fontSize: theme.fontTokens.sizeLabelLarge, fontWeight: FontWeight.w700, letterSpacing: theme.fontTokens.letterSpacingLabelLarge),
        side: BorderSide(
          color: onClick != null ? theme.componentsTokens.button.colorBorderDefaultEnabled : theme.componentsTokens.button.colorBorderDefaultDisabled,
          width: theme.componentsTokens.button.borderWidthDefault,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.componentsTokens.button.borderRadius),
        ),
        padding: EdgeInsets.only(
          top: theme.componentsTokens.button.spacePaddingBlock,
          right: theme.componentsTokens.button.spacePaddingInlineIconNone,
          bottom: theme.componentsTokens.button.spacePaddingBlock,
          left: theme.componentsTokens.button.spacePaddingInlineIconNone,
        ),
        minimumSize: Size(theme.componentsTokens.button.sizeMinWidth, theme.componentsTokens.button.sizeMinHeight),
      ),
      onPressed: onClick,
      child: Text(label!),
    );
  }
}
