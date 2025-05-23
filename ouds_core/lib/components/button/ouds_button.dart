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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/button/internal/button_loading_modifier.dart';
import 'package:ouds_core/components/button/internal/button_style_modifier.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// Enum for button hierarchy
enum OudsButtonHierarchy {
  defaultHierarchy,
  strong,
  minimal,
  negative,
}

/// Enum for button style
enum OudsButtonStyle {
  defaultStyle,
  loading,
}

/// Enum for button layout
enum OudsButtonLayout {
  textOnly,
  iconAndText,
  iconOnly;
}

/// [OUDS Button design guidelines](https://unified-design-system.orange.com/472794e18/p/48a788-button)
///
/// An OUDS button which displays text only.
///
/// In the case it is used in an [OudsColoredBox], its monochrome variant is automatically displayed.
/// Some tokens associated with these specific colors can be customized and are identified with the `Mono` suffix (for instance [OudsButtonTokens.colorBgDefaultEnabledMono]).
///
/// Parameters:
/// - [label]: Text displayed in the button.
/// - [icon]: Icon displayed in the button.
/// - [onPressed]: Callback invoked when the button is clicked.
///   Controls the enabled state of the button when [style] is equal to [OudsButtonStyle.defaultStyle]
///   When `false`, this button will not be clickable. Has no effect when [style] is equal to [OudsButtonStyle.loading].
/// - [style]: The button style.
/// - [hierarchy]: The button hierarchy.
///
/// **Samples**:
/// - [OudsButtonWithTextSample](com.orange.ouds.core.component.samples.OudsButtonWithTextSample)
/// - [OudsButtonWithTextOnColoredBackgroundSample](com.orange.ouds.core.component.samples.OudsButtonWithTextOnColoredBackgroundSample)
class OudsButton extends StatefulWidget {
  final String? label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final OudsButtonStyle style;
  final OudsButtonHierarchy hierarchy;

  const OudsButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    required this.style,
    required this.hierarchy,
  });

  @override
  State<OudsButton> createState() => _OudsButtonState();

  /// Property that detects and returns the button layout based on the provided elements (text and/or icon)
  OudsButtonLayout get layout => _detectLayout(label, icon);

  static OudsButtonLayout _detectLayout(String? label, Widget? icon) {
    if (label != null && icon != null) {
      return OudsButtonLayout.iconAndText;
    } else if (label != null) {
      return OudsButtonLayout.textOnly;
    } else if (icon != null) {
      return OudsButtonLayout.iconOnly;
    }
    return OudsButtonLayout.textOnly;
  }
}

class _OudsButtonState extends State<OudsButton> {
  @override
  Widget build(BuildContext context) {
    try {
      if (widget.hierarchy == OudsButtonHierarchy.negative && OudsTheme.isOnColoredSurfaceOf(context)) {
        // Throw an IllegalStateException
        throw StateError("An OudsButton with OudsButtonHierarchy.negative hierarchy cannot be displayed as a child of an OudsColoredBox.");
      }
    } catch (e) {
      debugPrint("Warning: ${e.toString()}");
    }
    switch (widget.layout) {
      case OudsButtonLayout.iconOnly:
        return _buildButtonIconOnly(context);
      case OudsButtonLayout.iconAndText:
        return _buildButtonIconAndText(context);
      case OudsButtonLayout.textOnly:
        return _buildButtonTextOnly(context);
    }
  }

  Widget _buildButtonIconAndText(BuildContext context) {
    switch (widget.style) {
      case OudsButtonStyle.defaultStyle:
        return ClipRRect(
          borderRadius: BorderRadius.circular(OudsTheme.of(context).componentsTokens(context).button.borderRadius),
          child: OutlinedButton(
            onPressed: widget.onPressed,
            style: ButtonStyleModifier.buildButtonStyle(context, hierarchy: widget.hierarchy, layout: widget.layout, style: widget.style),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.icon!,
                    SizedBox(
                      width: OudsTheme.of(context).componentsTokens(context).button.spaceColumnGapIcon,
                    ),
                    Flexible(
                      child: Text(
                        widget.label ?? "",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      case OudsButtonStyle.loading:
        return Semantics(
          label: OudsLocalizations.of(context)?.core_button_loading_a11y,
          button: true,
          child: ExcludeSemantics(
            child: OutlinedButton(
              onPressed: null,
              style: ButtonStyleModifier.buildButtonStyle(context, hierarchy: widget.hierarchy, layout: widget.layout, style: widget.style),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        null,
                        size: OudsTheme.of(context).componentsTokens(context).button.sizeIcon,
                      ),
                      SizedBox(
                        width: OudsTheme.of(context).componentsTokens(context).button.spaceColumnGapIcon,
                      ),
                      Flexible(
                        child: Text(
                          widget.label ?? "",
                          style: TextStyle(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: OudsTheme.of(context).componentsTokens(context).button.spaceColumnGapIcon),
                    child: _buildLoadingIndicator(context),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  Widget _buildButtonIconOnly(BuildContext context) {
    switch (widget.style) {
      case OudsButtonStyle.defaultStyle:
        return Semantics(
          label: OudsLocalizations.of(context)?.core_button_icon_only_a11y,
          button: true,
          child: ExcludeSemantics(
            child: IconButton(
              style: ButtonStyleModifier.buildButtonStyle(context, hierarchy: widget.hierarchy, layout: widget.layout),
              onPressed: widget.onPressed,
              icon: widget.icon!,
            ),
          ),
        );
      case OudsButtonStyle.loading:
        return Semantics(
          label: OudsLocalizations.of(context)?.core_button_loading_a11y,
          button: true,
          child: IconButton(
            onPressed: null,
            style: ButtonStyleModifier.buildButtonStyle(context, hierarchy: widget.hierarchy, layout: widget.layout, style: widget.style),
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: OudsTheme.of(context).opacityTokens.invisible,
                  child: Icon(Icons.favorite_border),
                ),
                _buildLoadingIndicator(context),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildButtonTextOnly(BuildContext context) {
    switch (widget.style) {
      case OudsButtonStyle.defaultStyle:
        return ClipRRect(
          borderRadius: BorderRadius.circular(OudsTheme.of(context).componentsTokens(context).button.borderRadius),
          child: OutlinedButton(
            style: ButtonStyleModifier.buildButtonStyle(context, hierarchy: widget.hierarchy, layout: widget.layout),
            onPressed: widget.onPressed,
            child: Text(
              widget.label ?? "",
              textAlign: TextAlign.center,
            ),
          ),
        );
      case OudsButtonStyle.loading:
        return Semantics(
          label: OudsLocalizations.of(context)?.core_button_loading_a11y,
          button: true,
          child: ExcludeSemantics(
            child: OutlinedButton(
              onPressed: null,
              style: ButtonStyleModifier.buildButtonStyle(context, hierarchy: widget.hierarchy, layout: widget.layout, style: widget.style),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: OudsTheme.of(context).opacityTokens.invisible,
                    child: Text(
                      widget.label ?? "",
                    ),
                  ),
                  _buildLoadingIndicator(context),
                ],
              ),
            ),
          ),
        );
    }
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return SizedBox(
      width: OudsTheme.of(context).componentsTokens(context).button.sizeLoader,
      height: OudsTheme.of(context).componentsTokens(context).button.sizeLoader,
      child: CircularProgressIndicator(
        color: ButtonLoadingModifier.getColorToken(context, widget.hierarchy),
        strokeWidth: 3,
      ),
    );
  }
}
