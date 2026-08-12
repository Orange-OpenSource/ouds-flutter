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
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_core/components/top_bar/ouds_top_bar.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_button_tokens.dart';

/// Defines the visual importance (appearance) of an [OudsButton] within the UI.
///
/// Use this enum to control the emphasis level of a button:
/// - [defaultAppearance]: standard button, suitable for most use cases.
/// - [strong]: high-emphasis button, used for the primary action on a screen.
/// - [brand]: button styled with the brand color.
/// - [minimal]: low-emphasis button, used for secondary or tertiary actions.
/// - [negative]: destructive or warning action. Not allowed inside an [OudsColoredBox].
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
enum OudsButtonLayout { textOnly, iconAndText, iconOnly }

///@nodoc
///
/// A private enum to use only into the lib
///
/// Defines the size of an [OudsButton].
///
/// Use this enum to control the overall dimensions (min size, paddings, icon size, …) of a button:
/// - [defaultSize]: standard size, suitable for most use cases.
/// - [small]: compact size, used when space is constrained.
enum OudsButtonSize { defaultSize, small }

///@nodoc
///
/// A private enum to use only into the lib
///
/// Defines the type of button component.
///
/// Use this enum to distinguish between a standard [OudsButton] and an [OudsNavigationButton]:
/// - [defaultButton]: standard button without navigation chevron.
/// - [navigationButton]: navigation button with next/previous chevron.
enum OudsButtonComponent {
  /// Standard button layout.
  defaultButton,

  /// Navigation button layout (with chevron).
  navigationButton,
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
/// ## Parameters
///
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

  /// The button size based on its [OudsButtonSize], set to [OudsButtonSize.defaultSize] by default.
  final OudsButtonSize _size;

  /// Distinguishes a standard button from an [OudsNavigationButton], since both are
  /// backed by this same widget internally.
  final OudsButtonComponent _component;

  /// Navigation layout used internally by [OudsNavigationButton].
  ///
  /// `null` for standard buttons.
  final OudsNavigationButtonLayout? _navigationLayout;

  /// Custom accessibility label used in icon-only navigation buttons.
  final String? _semanticsLabel;

  const OudsButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.loader,
    required this.appearance,
    this.package,
    this.isFullWidth = false,
  }) : _size = OudsButtonSize.defaultSize,
       _component = OudsButtonComponent.defaultButton,
       _navigationLayout = null,
       _semanticsLabel = null;

  /// Creates an [OudsButton] with [OudsButtonSize.small], for contexts where space is constrained.
  ///
  /// This is a convenience constructor equivalent to `OudsButton(size: OudsButtonSize.small, ...)`.
  ///
  /// ```dart
  /// OudsButton.small(
  ///       label: 'Button',
  ///       appearance: OudsButtonAppearance.defaultAppearance,
  ///       onPressed: () {
  ///         // Handle button tap.
  ///      },
  ///     );
  /// ```
  const OudsButton.small({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.loader,
    required this.appearance,
    this.package,
    this.isFullWidth = false,
  }) : _size = OudsButtonSize.small,
       _component = OudsButtonComponent.defaultButton,
       _navigationLayout = null,
       _semanticsLabel = null;

  /// Internal constructor used exclusively by [OudsNavigationButton].
  ///
  /// Do not use this constructor directly outside of `ouds_core`.
  const OudsButton._internal({
    required this.label,
    required this.icon,
    this.onPressed,
    required this.appearance,
    this.package,
    this.isFullWidth = false,
    OudsButtonSize size = OudsButtonSize.defaultSize,
    this.loader,
    required OudsNavigationButtonLayout navigationLayout,
    String? semanticsLabel,
  }) : _size = size,
       _component = OudsButtonComponent.navigationButton,
       _navigationLayout = navigationLayout,
       _semanticsLabel = semanticsLabel;

  @override
  State<OudsButton> createState() => _OudsButtonState();

  /// Property that detects and returns the button layout based on the provided elements (text and/or icon)
  OudsButtonLayout get layout => _detectLayout(label, icon, _navigationLayout);

  /// Derives the [OudsButtonLayout] from the supplied parameters.
  ///
  /// Rules:
  /// - Navigation button with a label → [OudsButtonLayout.iconAndText]
  /// - Navigation button without a label → [OudsButtonLayout.iconOnly]
  /// - Both [label] and [icon] provided → [OudsButtonLayout.iconAndText]
  /// - Only [label] provided → [OudsButtonLayout.textOnly]
  /// - Only [icon] provided → [OudsButtonLayout.iconOnly]
  static OudsButtonLayout _detectLayout(
    String? label,
    String? icon,
    OudsNavigationButtonLayout? navigationLayout,
  ) {
    if (navigationLayout != null) {
      return label != null
          ? OudsButtonLayout.iconAndText
          : OudsButtonLayout.iconOnly;
    }
    if (label != null && icon != null) return OudsButtonLayout.iconAndText;
    if (label != null) return OudsButtonLayout.textOnly;
    if (icon != null) return OudsButtonLayout.iconOnly;
    return OudsButtonLayout.textOnly;
  }

  /// Builds an icon-only button with an optional badge overlay.
  ///
  /// This method is **package-internal** and intended solely for use by
  /// [OudsTopBar] to render trailing action buttons with a badge.
  ///
  /// Do not call this method directly from application code.
  @internal
  Widget buildIconButtonWithBadge(
    BuildContext context,
    OudsTopBarActionBadge? badge,
    OudsButtonControlState buttonState,
  ) {
    return buildIconBadgeButton(
      context,
      layout,
      appearance,
      buttonState,
      onPressed,
      icon,
      badge,
      package,
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
    if (widget.onPressed == null)
      _isFocused = false; // Ignore focus changes if disabled
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
      if (widget.appearance == OudsButtonAppearance.negative &&
          OudsTheme.isOnColoredSurfaceOf(context)) {
        // Throw an IllegalStateException
        throw StateError(
          "An OudsButton with OudsButtonAppearance.negative appearance cannot be displayed as a child of an OudsColoredBox.",
        );
      }
    } catch (e) {
      debugPrint("Warning: ${e.toString()}");
    }

    final oudsTheme = OudsTheme.of(context);
    // Get the button's radius so the focus border matches.
    final buttonBorderRadius = OudsButtonBorderModifier.getBorderRadiusFocus(
      context,
    );

    return _isFocused
        ? Stack(
            clipBehavior: Clip
                .none, // Allows the border to overflow slightly if necessary.
            alignment: Alignment.center,
            children: [
              // The button itself. It defines the size of the Stack.
              _buildLayout(context, buttonState),

              // The focus border, drawn on top.
              // IgnorePointer prevents this border from intercepting clicks.
              Positioned.fill(
                //the focus border should be outside
                left: -oudsTheme.borderTokens.widthFocus,
                right: -oudsTheme.borderTokens.widthFocus,
                bottom: -oudsTheme.borderTokens.widthFocus,
                top: -oudsTheme.borderTokens.widthFocus,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      border: OudsBorder().borderAll(
                        color: oudsTheme.colorScheme(context).borderFocus,
                        width: oudsTheme.borderTokens.widthFocus / 2,
                      ),
                      // The border radius should match the button's radius.
                      borderRadius: buttonBorderRadius,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: OudsBorder().borderAll(
                          color: OudsTheme.of(
                            context,
                          ).colorScheme(context).borderFocusInset,
                          width: borderTokens.widthFocusInset,
                        ),
                        borderRadius: buttonBorderRadius,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : _buildLayout(context, buttonState);
  }

  /// Returns the label typography based on [widget._size]: [OudsButtonSize.defaultSize]
  /// uses the large strong label style, [OudsButtonSize.small] uses the medium one.
  TextStyle _labelTypography(BuildContext context) {
    final typography = OudsTheme.of(context).typographyTokens;
    return widget._size == OudsButtonSize.small
        ? typography.typeLabelStrongMedium(context)
        : typography.typeLabelStrongLarge(context);
  }

  /// Dispatches to the appropriate layout builder based on [widget.layout].
  Widget _buildLayout(
    BuildContext context,
    OudsButtonControlState buttonState,
  ) {
    final buttonToken = OudsTheme.of(context).componentsTokens(context).button;

    switch (widget.layout) {
      case OudsButtonLayout.iconOnly:
        return _buildButtonIconOnly(context, buttonState);
      case OudsButtonLayout.iconAndText:
        return Container(
          constraints: BoxConstraints(
            minWidth: buttonToken.sizeMinWidth(widget._size),
            minHeight: buttonToken.sizeMinHeight(widget._size),
          ),
          child: widget._component == OudsButtonComponent.navigationButton
              ? _buildNavigationButton(context, buttonState)
              : _buildButtonIconAndText(context, buttonState),
        );
      case OudsButtonLayout.textOnly:
        return _buildButtonTextOnly(context, buttonState);
    }
  }

  /// Builds the icon-and-text layout for a standard [OudsButton].
  Widget _buildButtonIconAndText(
    BuildContext context,
    OudsButtonControlState buttonState,
  ) {
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
              style: OudsButtonStyleModifier.buildButtonStyle(
                context,
                appearance: widget.appearance,
                layout: widget.layout,
                buttonState: buttonState,
                navigationLayout: widget._navigationLayout,
                componentType: widget._component,
                size: widget._size,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(null, size: buttonToken.sizeIcon(widget._size)),
                      SizedBox(
                        width: buttonToken.spaceColumnGapIcon(widget._size),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Opacity(
                          opacity: OudsTheme.of(
                            context,
                          ).opacityTokens.invisible,
                          child: Text(
                            widget.label ?? "",
                            style: _labelTypography(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: buttonToken.spaceColumnGapIconDefault,
                    ),
                    child: _buildLoadingIndicator(
                      context,
                      widget.loader?.progress,
                    ),
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
                  onPressed: widget.onPressed == null
                      ? null
                      : () => _handlePressed(widget.onPressed),
                  style: OudsButtonStyleModifier.buildButtonStyle(
                    context,
                    appearance: widget.appearance,
                    layout: widget.layout,
                    buttonState: buttonState,
                    navigationLayout: widget._navigationLayout,
                    componentType: widget._component,
                    size: widget._size,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildIcon(
                            context,
                            widget.icon!,
                            widget.appearance,
                            widget.layout,
                            buttonState,
                          ),
                          SizedBox(
                            width: buttonToken.spaceColumnGapIcon(widget._size),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              widget.label ?? "",
                              textAlign: TextAlign.center,
                              style: _labelTypography(context),
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

  /// Builds the navigation button layout (next or previous chevron with optional label).
  ///
  /// Used exclusively when [widget._navigationLayout] is not `null`, i.e. when
  /// [OudsButton] is instantiated via [OudsButton._internal] by [OudsNavigationButton].
  Widget _buildNavigationButton(
    BuildContext context,
    OudsButtonControlState buttonState,
  ) {
    final buttonToken = OudsTheme.of(context).componentsTokens(context).button;
    final isNextLayout =
        widget._navigationLayout == OudsNavigationButtonLayout.next;
    switch (buttonState) {
      case OudsButtonControlState.loading:
        final buttonIconAndText = Semantics(
          label: OudsLocalizations.of(context)?.core_common_loading_a11y,
          enabled: false,
          button: true,
          child: ExcludeSemantics(
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                OutlinedButton(
                  onPressed: null,
                  style: OudsButtonStyleModifier.buildButtonStyle(
                    context,
                    appearance: widget.appearance,
                    layout: widget.layout,
                    buttonState: buttonState,
                    navigationLayout: widget._navigationLayout,
                    componentType: widget._component,
                    size: widget._size,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          widget.label ?? "",
                          style: _labelTypography(
                            context,
                          ).copyWith(color: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        width: buttonToken.spaceColumnGapChevron(widget._size),
                      ),
                      Icon(null, size: buttonToken.sizeIcon(widget._size)),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: OudsButtonStyleModifier.buildButtonStyle(
                    context,
                    appearance: OudsButtonAppearance.minimal,
                    layout: OudsButtonLayout.iconOnly,
                    buttonState: buttonState,
                    navigationLayout: widget._navigationLayout,
                    componentType: widget._component,
                    size: widget._size,
                  ),
                  onPressed: null,
                  child: _buildLoadingIndicator(
                    context,
                    widget.loader?.progress,
                  ),
                ),
              ],
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
              label: widget.label ?? "${widget._semanticsLabel}",
              button: true,
              child: ExcludeSemantics(
                child: OutlinedButton(
                  focusNode: _focusNode,
                  onPressed: widget.onPressed == null
                      ? null
                      : () => _handlePressed(widget.onPressed),
                  style: OudsButtonStyleModifier.buildButtonStyle(
                    context,
                    appearance: widget.appearance,
                    layout: widget.layout,
                    buttonState: buttonState,
                    navigationLayout: widget._navigationLayout,
                    componentType: widget._component,
                    size: widget._size,
                  ),
                  child: isNextLayout
                      ? _buildNextNavigationButton(buttonState, buttonToken)
                      : _buildPreviousNavigationButton(
                          buttonState,
                          buttonToken,
                        ),
                ),
              ),
            ),
          ),
        );
        return _wrapFullWidth(buttonIconAndText);
    }
  }

  /// Builds the "next" navigation button content: label on the left, chevron on the right.
  Row _buildNextNavigationButton(
    OudsButtonControlState buttonState,
    OudsButtonTokens buttonToken,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            widget.label ?? "",
            textAlign: TextAlign.center,
            style: _labelTypography(context),
          ),
        ),
        SizedBox(width: buttonToken.spaceColumnGapChevron(widget._size)),
        _buildIcon(
          context,
          widget.icon!,
          widget.appearance,
          widget.layout,
          buttonState,
        ),
      ],
    );
  }

  /// Builds the "previous" navigation button content: chevron on the left, label on the right.
  Row _buildPreviousNavigationButton(
    OudsButtonControlState buttonState,
    OudsButtonTokens buttonToken,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIcon(
          context,
          widget.icon!,
          widget.appearance,
          widget.layout,
          buttonState,
        ),
        SizedBox(width: buttonToken.spaceColumnGapChevron(widget._size)),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            widget.label ?? "",
            textAlign: TextAlign.center,
            style: _labelTypography(context),
          ),
        ),
      ],
    );
  }

  /// Builds the icon-only layout for a standard or navigation [OudsButton].
  ///
  /// In navigation context, [widget._semanticsLabel] is used as the accessibility
  /// label instead of the default localized string.
  Widget _buildButtonIconOnly(
    BuildContext context,
    OudsButtonControlState buttonState,
  ) {
    final buttonToken = OudsTheme.of(context).componentsTokens(context).button;

    switch (buttonState) {
      case OudsButtonControlState.loading:
        final buttonIconOnly = Semantics(
          label: OudsLocalizations.of(context)?.core_common_loading_a11y,
          enabled: false,
          button: true,
          child: IconButton(
            onPressed: null,
            style: OudsButtonStyleModifier.buildButtonStyle(
              context,
              appearance: widget.appearance,
              layout: widget.layout,
              buttonState: buttonState,
              navigationLayout: widget._navigationLayout,
              componentType: widget._component,
              size: widget._size,
            ),
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: OudsTheme.of(context).opacityTokens.invisible,
                  child: _buildIcon(
                    context,
                    widget.icon!,
                    widget.appearance,
                    widget.layout,
                    buttonState,
                  ),
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
              label: widget._navigationLayout != null
                  ? widget._semanticsLabel
                  : OudsLocalizations.of(context)?.core_button_icon_only_a11y,
              button: true,
              enabled: widget.onPressed != null,
              child: ExcludeSemantics(
                child: SizedBox(
                  width: buttonToken.sizeMinWidth(widget._size),
                  child: IconButton(
                    focusNode: _focusNode,
                    style: OudsButtonStyleModifier.buildButtonStyle(
                      context,
                      appearance: widget.appearance,
                      layout: widget.layout,
                      buttonState: buttonState,
                      navigationLayout: widget._navigationLayout,
                      componentType: widget._component,
                      size: widget._size,
                    ),
                    onPressed: widget.onPressed == null
                        ? null
                        : () => _handlePressed(widget.onPressed),
                    icon: _buildIcon(
                      context,
                      widget.icon!,
                      widget.appearance,
                      widget.layout,
                      buttonState,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        return _wrapFullWidth(buttonIconOnly);
    }
  }

  /// Builds the text-only layout for a standard [OudsButton].
  Widget _buildButtonTextOnly(
    BuildContext context,
    OudsButtonControlState buttonState,
  ) {
    switch (buttonState) {
      case OudsButtonControlState.loading:
        final buttonTextOnly = Semantics(
          label: OudsLocalizations.of(context)?.core_common_loading_a11y,
          enabled: false,
          button: true,
          child: ExcludeSemantics(
            child: OutlinedButton(
              onPressed: null,
              style: OudsButtonStyleModifier.buildButtonStyle(
                context,
                appearance: widget.appearance,
                layout: widget.layout,
                buttonState: buttonState,
                componentType: widget._component,
                size: widget._size,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: OudsTheme.of(context).opacityTokens.invisible,
                    child: Text(
                      widget.label ?? "",
                      style: _labelTypography(context),
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
          style: OudsButtonStyleModifier.buildButtonStyle(
            context,
            appearance: widget.appearance,
            layout: widget.layout,
            buttonState: buttonState,
            componentType: widget._component,
            size: widget._size,
          ),
          onPressed: widget.onPressed == null
              ? null
              : () => _handlePressed(widget.onPressed),
          child: Text(
            widget.label ?? "",
            textAlign: TextAlign.center,
            style: _labelTypography(context),
          ),
        );
        return _wrapFullWidth(buttonTextOnly);
    }
  }

  /// Builds the circular loading indicator shown inside the button during a loading state.
  ///
  /// [progress] is clamped to `[0.0, 1.0]`. Pass `null` for an indeterminate spinner.
  //todo will be replaced by OudsCircularProgressIndicator when it will be available in core
  Widget _buildLoadingIndicator(BuildContext context, double? progress) {
    {
      final clampedProgress = progress?.clamp(0.0, 1.0);
      final progressIndicatorSize = OudsTheme.of(
        context,
      ).componentsTokens(context).button.sizeProgressIndicator(widget._size);
      return Padding(
        padding: EdgeInsetsDirectional.all(
          OudsTheme.of(context)
              .componentsTokens(context)
              .button
              .spaceProgressIndicator(widget._size),
        ),
        child: SizedBox(
          width: progressIndicatorSize,
          height: progressIndicatorSize,
          child: CircularProgressIndicator(
            value: clampedProgress,
            color: OudsButtonLoadingModifier.getColorToken(
              context,
              widget.appearance,
            ),
            strokeWidth: widget._size == OudsButtonSize.small ? 2 : 3,
          ),
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
      return SizedBox(width: double.infinity, child: child);
    }
    return child;
  }

  /// Renders the correct SVG icon for the current button state and appearance.
  ///
  /// For navigation buttons, the chevron asset is selected based on
  /// [widget._navigationLayout] ([OudsNavigationButtonLayout.next] or
  /// [OudsNavigationButtonLayout.previous]). The icon is scaled with the
  /// system text scale factor, clamped between `1.0×` and `2.0×`.
  ///
  /// For standard buttons, the [assetName] SVG is rendered with a color
  /// filter matching the current [buttonState] and [appearance].
  Widget _buildIcon(
    BuildContext context,
    String assetName,
    final OudsButtonAppearance appearance,
    final OudsButtonLayout layout,
    final OudsButtonControlState buttonState,
  ) {
    // navigation button
    final textScaleFactor = MediaQuery.textScalerOf(context).scale(1.0);
    final baseIconSize = OudsButtonIconModifier.getIconSize(
      context,
      layout,
      size: widget._size,
    );
    final scaledIconSize = baseIconSize * textScaleFactor.clamp(1.0, 2.0);

    if (widget._navigationLayout != null) {
      switch (widget._navigationLayout) {
        case OudsNavigationButtonLayout.next:
          return SvgPicture.asset(
            package: widget.package,
            AppAssets.icons.componentButtonNext,
            matchTextDirection: true,
            fit: BoxFit.contain,
            width: scaledIconSize,
            height: scaledIconSize,
            colorFilter: ColorFilter.mode(
              OudsButtonIconModifier.getIconColor(
                context,
                buttonState,
                appearance,
              ),
              BlendMode.srcIn,
            ),
          );

        case OudsNavigationButtonLayout.previous:
          return SvgPicture.asset(
            package: widget.package,
            AppAssets.icons.componentButtonPrevious,
            matchTextDirection: true,
            fit: BoxFit.contain,
            width: OudsButtonIconModifier.getIconSize(
              context,
              layout,
              size: widget._size,
            ),
            height: OudsButtonIconModifier.getIconSize(
              context,
              layout,
              size: widget._size,
            ),
            colorFilter: ColorFilter.mode(
              OudsButtonIconModifier.getIconColor(
                context,
                buttonState,
                appearance,
              ),
              BlendMode.srcIn,
            ),
          );
        case null:
          throw UnimplementedError();
      }
    }
    return SvgPicture.asset(
      excludeFromSemantics: true,
      package: widget.package,
      assetName,
      matchTextDirection: true,
      fit: BoxFit.contain,
      width: OudsButtonIconModifier.getIconSize(
        context,
        layout,
        size: widget._size,
      ),
      height: OudsButtonIconModifier.getIconSize(
        context,
        layout,
        size: widget._size,
      ),
      colorFilter: ColorFilter.mode(
        OudsButtonIconModifier.getIconColor(context, buttonState, appearance),
        BlendMode.srcIn,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// OudsNavigationButton
// ---------------------------------------------------------------------------

/// Defines the visual importance of an [OudsNavigationButton].
///
/// Unlike [OudsButtonAppearance], the `negative` value is intentionally absent
/// because navigation buttons are never used for destructive actions.
enum OudsNavigationButtonAppearance {
  defaultAppearance,
  strong,
  brand,
  minimal,
}

///The [OudsNavigationButtonLayout] defines the layout of the navigation button's content.
///
/// This enum controls whether the button displays next chevron or previous chevron.
enum OudsNavigationButtonLayout { next, previous }

/// [OUDS Navigation Button design guidelines](https://unified-design-system.orange.com/472794e18/p/1469c4-navigation-button)
///
/// **Reference design version : 3.3.0**
///
/// Navigation Button is a UI element used for navigating between screens or pages in a sequence.
/// It appears in different appearances and states to provide clear directional affordance.
///
/// This component is built on top of [OudsButton] and supports two layouts:
/// This component is implemented as a thin wrapper around [OudsButton] and
/// shares the same visual states (enabled, disabled, hovered, focused, loading).
///
/// Two layouts are available:
/// - **[OudsNavigationButtonLayout.next]**: label on the left, chevron (→) on the right.
/// - **[OudsNavigationButtonLayout.previous]**: chevron (←) on the left, label on the right.
///
/// When no [label] is provided, the button renders in **icon-only** mode.
/// Always supply a [semanticsLabel] in that case to satisfy accessibility requirements.
///
/// ## Parameters
///
/// - [layout]: Direction of navigation. **Required.**
/// - [appearance]: Visual importance of the button. **Required.**
/// - [label]: Optional text label describing the navigation action.
/// - [onPressed]: Callback invoked on tap. Pass `null` to disable the button.
/// - [loader]: Optional [Loader] displaying a loading indicator inside the button.
/// - [isFullWidth]: When `true`, the button expands to fill the full width. Defaults to `false`.
/// - [semanticsLabel]: Accessibility label used in icon-only mode when no [label] is provided.
/// - [package]: Package name to resolve the chevron asset when it comes from a package.
/// - [size]: The button size based on its [OudsButtonSize], set to [OudsButtonSize.defaultSize] by default.
///
/// ### Usage examples:
///
/// **Next navigation button:**
/// ```dart
/// OudsNavigationButton(
///   label: 'Next step',
///   layout: OudsNavigationButtonLayout.next,
///   appearance: OudsNavigationButtonAppearance.defaultAppearance,
///   onPressed: () {
///     // Navigate to the next screen.
///   },
/// );
///
///
/// **Icon-only navigation button (accessibility label required):**
/// ```dart
/// OudsNavigationButton(
///   layout: OudsNavigationButtonLayout.next,
///   appearance: OudsNavigationButtonAppearance.defaultAppearance,
///   semanticsLabel: 'Go to next page',
///   onPressed: () {},
/// );
/// ```
///
class OudsNavigationButton extends StatelessWidget {
  final OudsNavigationButtonLayout layout;
  final OudsNavigationButtonAppearance appearance;
  final String? label;
  final VoidCallback? onPressed;
  final Loader? loader;
  final String? package;
  final bool? isFullWidth;
  final String? semanticsLabel;
  final OudsButtonSize size;

  const OudsNavigationButton({
    super.key,
    this.label,
    this.onPressed,
    required this.layout,
    required this.appearance,
    this.package,
    this.loader,
    this.isFullWidth,
    this.semanticsLabel,
    this.size = OudsButtonSize.defaultSize,
  });

  @override
  Widget build(BuildContext context) {
    // Map NavigationButton appearance to Button appearance
    final buttonAppearance = _mapToButtonAppearance(appearance);

    // Get the appropriate chevron icon based on layout
    final icon = getDefaultChevronIcon(layout);

    // Use OudsButton with chevron and text
    // Note: OudsButton places the icon before the text by default.
    // For "next" layout (chevron after text), this need customization.
    // For "previous" layout (chevron before text), the default behavior of OudsButton.

    return OudsButton._internal(
      label: label,
      icon: icon,
      onPressed: onPressed,
      appearance: buttonAppearance,
      package: package,
      navigationLayout: layout,
      isFullWidth: isFullWidth,
      loader: loader,
      semanticsLabel: semanticsLabel,
      size: size,
    );
  }

  /// Maps an [OudsNavigationButtonAppearance] value to its [OudsButtonAppearance] equivalent.
  ///
  /// The `negative` value of [OudsButtonAppearance] is excluded because it is
  /// not valid for navigation buttons.
  OudsButtonAppearance _mapToButtonAppearance(
    OudsNavigationButtonAppearance appearance,
  ) {
    switch (appearance) {
      case OudsNavigationButtonAppearance.defaultAppearance:
        return OudsButtonAppearance.defaultAppearance;
      case OudsNavigationButtonAppearance.strong:
        return OudsButtonAppearance.strong;
      case OudsNavigationButtonAppearance.brand:
        return OudsButtonAppearance.brand;
      case OudsNavigationButtonAppearance.minimal:
        return OudsButtonAppearance.minimal;
    }
  }
}
