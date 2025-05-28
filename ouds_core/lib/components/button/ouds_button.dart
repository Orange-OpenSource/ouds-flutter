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

/// The [OudsButtonHierarchy] enum defines the visual importance of the button within the UI.
enum OudsButtonHierarchy {
  defaultHierarchy,
  strong,
  minimal,
  negative,
}

/// The [OudsButtonStyle] defines the button's visual behavior and feedback.
enum OudsButtonStyle {
  defaultStyle,
  loading,
}

///The [OudsButtonLayout] defines the layout of the button’s content.
///
/// This enum controls whether the button displays text, an icon, or both.
enum OudsButtonLayout {
  textOnly,
  iconAndText,
  iconOnly;
}

/// [OUDS Button design guidelines](https://unified-design-system.orange.com/472794e18/p/48a788-button)
///
/// Buttons are interactive elements designed to trigger specific actions or events when tapped by a user.
///
/// This version of the button uses the *text only* layout which is the most used layout.
/// Other layouts are available for this component: *text + icon* and *icon only*.
///
/// Note that in the case it is placed in an [OudsColoredBox], its monochrome variant is automatically displayed.
/// Some tokens associated with these specific colors can be customized and are identified with the `Mono` suffix (for instance [OudsButtonTokens.colorBgDefaultEnabledMono]).
///
/// Parameters:
/// - [label]: Label displayed in the button which describes the button action. Use action verbs or phrases to tell the user what will happen next.
/// - [icon]: Icon displayed in the button. Use an icon to add additional affordance where the icon has a clear and well-established meaning.
/// - [onPressed]: Callback invoked when the button is clicked.
///   Controls the enabled state of the button when [style] is equal to [OudsButtonStyle.defaultStyle]
///   When `false`, this button will not be clickable. Has no effect when [style] is equal to [OudsButtonStyle.loading].
/// - [style]: The [OudsButtonStyle] used for the button. Use [OudsButtonStyle.defaultStyle] for a standard button, or [OudsButtonStyle.loading] to indicate
///   an ongoing operation.
/// - [hierarchy]: The button appearance based on its [OudsButtonHierarchy].
///   A button with [OudsButtonHierarchy.negative] hierarchy is not allowed as a direct or indirect child of an [OudsColoredBox] and will throw an [IllegalStateException].
///
/// ## You can use [OudsButton] like this :
///
/// ### Text only button sample :
///
/// ```dart
/// OudsButton(
///       label: 'Label',
///       style: OudsButtonStyle.defaultStyle,
///       hierarchy: OudsButtonHierarchy.defaultHierarchy,
///       onPressed: () {
///         // Handle button tap.
///      },
///     );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/text_only.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/text_only_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
///
///
/// ### Icon and text button sample:
///
/// ```dart
/// OudsButton(
///       icon: Icon(Icons.favorite_border),
///       label: 'Label',
///       onPressed: () {
///           // Handle button tap.
///       },
///       style: OudsButtonStyle.defaultStyle,
///       hierarchy: OudsButtonHierarchy.defaultHierarchy,
///     );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/text_icon.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/text_icon_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
///
/// ### Icon only button sample:
///
/// ```dart
/// OudsButton(
///       icon: Icon(Icons.favorite_border),
///       style: OudsButtonStyle.defaultStyle,
///       hierarchy: OudsButtonHierarchy.defaultHierarchy,
///       onPressed: () {
///         // Handle button tap.
///      },
///     );
/// ```
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/icon_only.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/icon_only_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
/// ### Style Loading sample:
///
/// ```dart
/// OudsButton(
///       label: 'Label',
///       style: OudsButtonStyle.loading,
///       hierarchy: OudsButtonHierarchy.defaultHierarchy,
///       onPressed: null,
///     );
/// ```
///
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/default_loading.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/default_loading_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
///
///
///
/// ### Style Loading and hierarchy negative sample:
///
/// ```dart
/// OudsButton(
///       label: 'Label',
///       style: OudsButtonStyle.loading,
///       hierarchy: OudsButtonHierarchy.negative,
///       onPressed: null,
///     );
/// ```
///
///
/// <div style="display: flex; gap: 24px; justify-content: center;">
///   <div style="text-align: center; width: 48%;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/negative_loading.png" alt="Light mode" width="100%">
///     <p style="margin-top: 8px;">Light mode</p>
///   </div>
///   <div style="text-align: center; width: 48%; justify-content: center;">
///     <img src="https://raw.githubusercontent.com/Orange-OpenSource/ouds-flutter/refs/heads/dependabot/pub/dartdoc-8.3.4/doc/images/button/negative_loading_dark.png" alt="Dark mode" width="100%">
///     <p style="margin-top: 8px;">Dark mode</p>
///   </div>
/// </div>
///
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
