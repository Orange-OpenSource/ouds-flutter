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

/// {@category Button}
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/button/internal/ouds_button_border_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_control_state.dart';
import 'package:ouds_core/components/button/internal/ouds_button_icon_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_loading_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_style_modifier.dart';
import 'package:ouds_core/components/button/internal/ouds_button_utils.dart';
import 'package:ouds_core/components/top_bar/ouds_top_appbar.dart';
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

/// The [OudsButtonAppearance] enum defines the visual importance of the button within the UI.
enum OudsButtonAppearance {
  defaultAppearance,
  strong,
  brand,
  minimal,
  negative,
}

///
/// A circular loading indicator displayed in the button.
///
/// param [progress] The loading progress, where 0.0 represents no progress and 1.0 represents full progress.
///   Values outside of this range are coerced into the range.
///  Set this value to `null` to display a circular indeterminate progress indicator.
///
class Loader {
  final double? progress;
  Loader({this.progress});
}

///The [OudsButtonLayout] defines the layout of the button’s content.
///
/// This enum controls whether the button displays text, an icon, or both.
enum OudsButtonLayout {
  textOnly,
  iconAndText,
  iconOnly;
}

/// [OUDS Button design guidelines](https://r.orange.fr/r/S-ouds-doc-button)
///
/// **Reference design version : 3.2.0**
///
/// Button is a UI element that triggers an action or event, and is used to initiate tasks or confirming an action.
/// Button appears in different layouts, styles and states to indicate hierarchy or emphasis.
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
///   Controls the enabled state of the button when [loader] is equal to null.
///   When `false`, this button will not be clickable. Has no effect when [loader] is not null.
/// - [loader]: An optional loading progress indicator displayed in the button to indicate an ongoing operation.
/// - [appearance]: The button appearance based on its [OudsButtonAppearance].
///   A button with [OudsButtonAppearance.negative] appearance is not allowed as a direct or indirect child of an [OudsColoredBox] and will throw an [IllegalStateException].
///   To create the widget with an asset from a package, the [package] argument
///   must be provided. For instance, suppose a package called `my_icons` has
///   `icons/heart.svg` .
/// - [isFullWidth]: Flag to let button take all the screen width, set to *false* by default.
///
/// ### You can use [OudsButton] component in your project, customizing parameters as needed :
///
/// **Text only button :**
///
/// This is the default layout of the component.
///
///
/// ```dart
/// OudsButton(
///       isFullWidth: false,
///       label: 'Button',
///       appearance: OudsButtonAppearance.defaultAppearance,
///       onPressed: () {
///         // Handle button tap.
///      },
///     );
/// ```
/// ```dart
///
/// This is the Loading layout of the component.
///
/// OudsButton(
///       isFullWidth: false,
///       label: 'Button',
///       loader: Loader(progress: null),
///       appearance: OudsButtonAppearance.defaultAppearance
///       onPressed: () {
///         // Handle button tap.
///      },
///     );
/// ```
///
///
class OudsButton extends StatefulWidget {
  final String? label;
  final String? icon;
  final VoidCallback? onPressed;
  final Loader? loader;
  final OudsButtonAppearance appearance;
  final String? package;
  final bool? isFullWidth;

  const OudsButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.loader,
    required this.appearance,
    this.package,
    this.isFullWidth = false,
  });

  @override
  State<OudsButton> createState() => _OudsButtonState();

  /// Property that detects and returns the button layout based on the provided elements (text and/or icon)
  OudsButtonLayout get layout => _detectLayout(label, icon);

  static OudsButtonLayout _detectLayout(String? label, String? icon) {
    if (label != null && icon != null) {
      return OudsButtonLayout.iconAndText;
    } else if (label != null) {
      return OudsButtonLayout.textOnly;
    } else if (icon != null) {
      return OudsButtonLayout.iconOnly;
    }
    return OudsButtonLayout.textOnly;
  }

  ///nodoc
  // Keeps the notice that this is for package-internal use.
  // this methode used for top app bar trailing action to manage the badge into the icon button
  @internal
  Widget buildIconButtonWithBadge(BuildContext context,
      OudsTopAppBarActionBadge? badge,
      OudsButtonControlState buttonState) {
    return buildIconBadgeButton(
        context, layout, appearance,
        buttonState, onPressed, icon,
        badge, package
    );
  }
}

class _OudsButtonState extends State<OudsButton> {
  // Tracks hover and press states manually for custom SVG icon rendering.
  //
  // Flutter’s [ButtonStyle] uses [WidgetStateProperty] for styling based on
  // states like hovered, focused, or pressed. However, this does not apply
  // directly to SVGs via [colorFilter].
  //
  // To support dynamic color changes on SVG icons, we track interaction
  // states manually using [MouseRegion] and [GestureDetector], enabling us to
  // update the icon style accordingly.
  bool _isHovered = false;
  bool _isPressed = false;

  // Tracks keyboard focus highlight to make focus visible when navigating with a keyboard.
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _handleFocusChange(_focusNode.hasFocus);
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool focus) {
    if (widget.onPressed == null) _isFocused = false; // Ignore focus changes if disabled
    setState(() => _isFocused = focus);
  }

  void _handlePressed(VoidCallback? callback) {
    setState(() {
      _isPressed = true;
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      callback?.call();
      if (mounted) {
        setState(() {
          _isPressed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determines the local visual state of the button (hovered, pressed, etc.)
    // using internal flags managed via a [MouseRegion] and gesture listeners.
    // This state is used to compute dynamic styling (e.g., background color).
    final buttonStateDeterminer = OudsButtonControlStateDeterminer(
      enabled: widget.onPressed != null,
      isPressed: _isPressed,
      isHovered: _isHovered,
      isFocused: _isFocused,
      isLoading: widget.loader != null,
    );
    final buttonState = buttonStateDeterminer.determineControlState();
    final borderTokens = OudsTheme.of(context).borderTokens;

    try {
      if (widget.appearance == OudsButtonAppearance.negative && OudsTheme.isOnColoredSurfaceOf(context)) {
        // Throw an IllegalStateException
        throw StateError("An OudsButton with OudsButtonAppearance.negative appearance cannot be displayed as a child of an OudsColoredBox.");
      }
    } catch (e) {
      debugPrint("Warning: ${e.toString()}");
    }

    return Container(
      decoration: BoxDecoration(
        border: OudsBorder().borderAll(
          color: _isFocused
              ? OudsTheme.of(context).colorScheme(context).borderFocus
              : Colors.transparent,
          width: borderTokens.widthFocus / 2,
        ),
          borderRadius: BorderRadiusGeometry.circular(
            OudsButtonBorderModifier.getDoubleRadiusFocus(context),
          )
      ),
      child: Container(
        decoration: BoxDecoration(
            border: OudsBorder().borderAll(
              color: _isFocused
                  ? OudsTheme.of(context).colorScheme(context).borderFocusInset
                  : Colors.transparent,
              width: borderTokens.widthFocusInset,
            ),
            borderRadius: BorderRadiusGeometry.circular(
              OudsButtonBorderModifier.getDoubleRadiusFocus(context),
            )
        ),
        child: _buildLayout(
          context,
          buttonState,
        ),
      ),
    );
  }

  Widget _buildLayout(
    BuildContext context,
    OudsButtonControlState buttonState,
  ) {
    switch (widget.layout) {
      case OudsButtonLayout.iconOnly:
        return _buildButtonIconOnly(context, buttonState);
      case OudsButtonLayout.iconAndText:
        return _buildButtonIconAndText(context, buttonState);
      case OudsButtonLayout.textOnly:
        return _buildButtonTextOnly(context, buttonState);
    }
  }

  Widget _buildButtonIconAndText(BuildContext context, OudsButtonControlState buttonState) {
    final buttonToken = OudsTheme.of(context).componentsTokens(context).button;
    switch (buttonState) {
      case OudsButtonControlState.loading:
        final buttonIconAndText = Semantics(
          label: OudsLocalizations.of(context)?.core_common_loading_a11y,
          enabled: false,
          button: true,
          child: ExcludeSemantics(
            child: OutlinedButton(
              onPressed: null,
              style: OudsButtonStyleModifier.buildButtonStyle(context, appearance: widget.appearance, layout: widget.layout, buttonState: buttonState),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        null,
                        size: buttonToken.sizeIcon,
                      ),
                      SizedBox(
                        width: buttonToken.spaceColumnGapIcon,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
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
                    padding: EdgeInsetsDirectional.only(start: buttonToken.spaceColumnGapIcon),
                    child: _buildLoadingIndicator(context, widget.loader?.progress),
                  ),
                ],
              ),
            ),
          ),
        );
        return _wrapFullWidth(buttonIconAndText);
      default:
        final buttonIconAndText = MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            child: Semantics(
              label: widget.label ?? "",
              button: true,
              child: ExcludeSemantics(
                child: OutlinedButton(
                  focusNode: _focusNode,
                  onPressed: widget.onPressed == null ? null : () => _handlePressed(widget.onPressed),
                  style: OudsButtonStyleModifier.buildButtonStyle(context, appearance: widget.appearance, layout: widget.layout, buttonState: buttonState),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildIcon(context, widget.icon!, widget.appearance, widget.layout, buttonState),
                          SizedBox(
                            width: buttonToken.spaceColumnGapIcon,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
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
              ),
            ),
          ),
        );
        return _wrapFullWidth(buttonIconAndText);
    }
  }

  Widget _buildButtonIconOnly(BuildContext context, OudsButtonControlState buttonState) {
    final buttonToken = OudsTheme.of(context).componentsTokens(context).button;

    switch (buttonState) {
      case OudsButtonControlState.loading:
        final buttonIconOnly = Semantics(
          label: OudsLocalizations.of(context)?.core_common_loading_a11y,
          enabled: false,
          button: true,
          child: IconButton(
            onPressed: null,
            style: OudsButtonStyleModifier.buildButtonStyle(context, appearance: widget.appearance, layout: widget.layout, buttonState: buttonState),
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: OudsTheme.of(context).opacityTokens.invisible,
                  child: _buildIcon(context, widget.icon!, widget.appearance, widget.layout, buttonState),
                ),
                _buildLoadingIndicator(context, widget.loader?.progress),
              ],
            ),
          ),
        );
        return _wrapFullWidth(buttonIconOnly);
      default:
        final buttonIconOnly = MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            child: Semantics(
              label: OudsLocalizations.of(context)?.core_button_icon_only_a11y,
              button: true,
              child: ExcludeSemantics(
                child: SizedBox(
                  width: buttonToken.sizeMinWidth,
                  child: IconButton(
                    focusNode: _focusNode,
                    style: OudsButtonStyleModifier.buildButtonStyle(context, appearance: widget.appearance, layout: widget.layout, buttonState: buttonState),
                    onPressed: widget.onPressed == null ? null : () => _handlePressed(widget.onPressed),
                    icon: _buildIcon(context, widget.icon!, widget.appearance, widget.layout, buttonState),
                  ),
                ),
              ),
            ),
          ),
        );
        return _wrapFullWidth(buttonIconOnly);
    }
  }

  Widget _buildButtonTextOnly(BuildContext context, OudsButtonControlState buttonState) {
    switch (buttonState) {
      case OudsButtonControlState.loading:
        final buttonTextOnly = Semantics(
          label: OudsLocalizations.of(context)?.core_common_loading_a11y,
          enabled: false,
          button: true,
          child: ExcludeSemantics(
            child: OutlinedButton(
              onPressed: null,
              style: OudsButtonStyleModifier.buildButtonStyle(context, appearance: widget.appearance, layout: widget.layout, buttonState: buttonState),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: OudsTheme.of(context).opacityTokens.invisible,
                    child: Text(
                      widget.label ?? "",
                    ),
                  ),
                  _buildLoadingIndicator(context, widget.loader?.progress),
                ],
              ),
            ),
          ),
        );
        return _wrapFullWidth(buttonTextOnly);
      default:
        final buttonTextOnly = OutlinedButton(
          focusNode: _focusNode,
          style: OudsButtonStyleModifier.buildButtonStyle(context, appearance: widget.appearance, layout: widget.layout, buttonState: buttonState),
          onPressed: widget.onPressed == null ? null : () => _handlePressed(widget.onPressed),
          child: Text(
            widget.label ?? "",
            textAlign: TextAlign.center,
          ),
        );
        return _wrapFullWidth(buttonTextOnly);
    }
  }

  Widget _buildLoadingIndicator(BuildContext context, double? progress) {
    {
      final clampedProgress = progress?.clamp(0.0, 1.0);
      return SizedBox(
        width: OudsTheme.of(context).componentsTokens(context).button.sizeLoader,
        height: OudsTheme.of(context).componentsTokens(context).button.sizeLoader,
        child: CircularProgressIndicator(
          value: clampedProgress,
          color: OudsButtonLoadingModifier.getColorToken(context, widget.appearance),
          strokeWidth: 3,
        ),
      );
    }
  }

  /// Expands the button to fill the available horizontal space when [widget.isFullWidth] is true.
  ///
  /// When `isFullWidth` is `true`, the returned widget wraps [child] in a [SizedBox] with
  /// `width: double.infinity`, allowing the button to stretch to the maximum width allowed by
  /// its parent constraints. When `isFullWidth` is `false` (default), [child] is returned as-is.
  Widget _wrapFullWidth(Widget child) {
    if (widget.isFullWidth == true) {
      return SizedBox(
        width: double.infinity,
        child: child,
      );
    }
    return child;
  }

  Widget _buildIcon(
    BuildContext context,
    String assetName,
    final OudsButtonAppearance appearance,
    final OudsButtonLayout layout,
    final OudsButtonControlState buttonState,
  ) {
    return SvgPicture.asset(
      excludeFromSemantics: true,
      package: widget.package,
      assetName,
      matchTextDirection: true,
      fit: BoxFit.contain,
      width: OudsButtonIconModifier.getIconSize(context, layout),
      height: OudsButtonIconModifier.getIconSize(context, layout),
      colorFilter: ColorFilter.mode(
        OudsButtonIconModifier.getIconColor(context, buttonState, appearance),
        BlendMode.srcIn,
      ),
    );
  }
}
