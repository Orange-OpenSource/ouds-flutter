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

/// {@category Link}
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/link/internal/ouds_link_control_state.dart';
import 'package:ouds_core/components/link/internal/ouds_link_size_modifier.dart';
import 'package:ouds_core/components/link/internal/ouds_link_status_modifier.dart';
import 'package:ouds_core/components/link/internal/ouds_link_text_style_modifier.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

///The [OudsLinkLayout] defines the layout of the link's content.
///
/// This enum controls whether the link displays text, text and icon, previous or next.
@Deprecated(
  'OudsLinkLayout is deprecated and will be removed in a future version. '
  'Use the dedicated OudsLink.icon, OudsLink.previous, OudsLink.next constructors instead. '
  ' a new indicator added OudsLink.external.',
)
enum OudsLinkLayout { textOnly, textAndIcon, back, next }

/// @nodoc
/// this is an internal enum should not be exposed to the user
/// Represents the type of chevron displayed in an [OudsLink].
enum OudsLinkIndicator {
  /// Used for "backward" navigation. Positioned before the label, it features a "chevron left" icon, which is not customizable.
  previous,

  /// Used in a standard navigation context. Positioned after the label, it features a "chevron right" icon, which is not customizable.
  next,

  /// Used to navigate outside the current product, service or application. The external navigation indicator informs users that the destination belongs to another context.
  external,
}

/// The [OudsLinkSize] defines the link's visual size.
enum OudsLinkSize { defaultSize, small }

/// The [OudsLinkDensity] defines the link's density
enum OudsLinkDensity {
  /// This is the default density of the component, recommended for most interfaces and primary navigation contexts.
  ///
  /// This density which is used for the vast majority of applications, provides a comfortable touch target that meets accessibility recommendations.
  defaultDensity,

  /// Reduces the vertical footprint while preserving the same interaction and visual behavior.
  ///
  /// Use in dense layouts where space is limited and a smaller touch target is acceptable (desktop or pointer-based contexts).
  compact,
}

/// [OUDS Link design guidelines](https://r.orange.fr/r/S-ouds-doc-link)
///
/// **Reference design version : 2.4.0**
///
/// Link is a UI element that allows to navigate from one location to another, either within the same page
/// or across different pages in the same resource, or to an external resource. Link's primary function is navigation
/// and it communicates its interactive nature visually and semantically.
///
///
/// parameters :
/// - [size] : The size of the link, [OudsLinkSize] such as small or default, to fit various visual needs.
/// - [density] : The density of the link, [OudsLinkDensity] such as compact or default.
/// - [label] : A text to display in link component.
/// - [icon] : An optional SVG asset name to display an icon within the link (used with [OudsLink.icon]).
/// - [tinted] : Whether the icon is tinted with the link's text/icon color, only used with [OudsLink.icon].
/// - [onPressed]: Callback invoked when the link is clicked.
///
/// [OudsLink] provides a dedicated named constructor for every supported variant:
/// - The default (unnamed) constructor renders a text-only link.
/// - [OudsLink.icon] renders a label with a custom icon.
/// - [OudsLink.previous] renders a "backward" navigation link with a leading chevron.
/// - [OudsLink.next] renders a "forward" navigation link with a trailing chevron.
/// - [OudsLink.external] renders a link navigating outside the current context, with a trailing indicator.
///
///
/// ### You can use [OudsLink] component in your project, customizing parameters as needed :
///
/// ### Small Text only :
///
/// This is the default layout of the component.
///
/// ```dart
/// OudsLink(
///       label: 'Label',
///       size: OudsLinkSize.small,
///       onPressed: () {}
///     );
/// ```
///
/// ### Next :
///
/// ```dart
/// OudsLink.next(
///       label: 'Label',
///       onPressed: () {}
///     );
/// ```
///
/// ### Previous :
///
/// ```dart
/// OudsLink.previous(
///       label: 'Label',
///       onPressed: () {}
///     );
/// ```
///
/// ### External :
///
/// ```dart
/// OudsLink.external(
///       label: 'Label',
///       onPressed: () {}
///     );
/// ```
///
/// ### Link with Icon :
///
/// ```dart
/// OudsLink.icon(
///       label: 'Label',
///       icon: 'assets/ic_heart.svg',
///       tinted: true,
///       onPressed: () {}
///     );
/// ```
///
/// ### Compact density link :
///
/// Reduces the link's minimum height and block padding, useful in dense layouts.
///
/// ```dart
/// OudsLink(
///       label: 'Label',
///       density: OudsLinkDensity.compact,
///       onPressed: () {}
///     );
/// ```
///
///
class OudsLink extends StatefulWidget {
  final String label;
  final String? icon;
  final bool? tinted;
  @Deprecated(
    'OudsLinkLayout is deprecated and will be removed in a future version. '
    'Use the dedicated OudsLink.icon, OudsLink.previous, OudsLink.next or '
    'OudsLink.external constructors instead.',
  )
  final OudsLinkLayout layout;
  final OudsLinkSize size;
  final OudsLinkDensity density;
  final VoidCallback? onPressed;

  final OudsLinkIndicator? _indicator;

  /// Creates a text-only [OudsLink].
  const OudsLink({
    super.key,
    required this.label,
    @Deprecated(
      'OudsLinkLayout is deprecated and will be removed in a future version. '
      'Use the dedicated OudsLink.icon, OudsLink.previous, OudsLink.next or '
      'OudsLink.external constructors instead.',
    )
    this.layout = OudsLinkLayout.textOnly,
    this.size = OudsLinkSize.defaultSize,
    this.density = OudsLinkDensity.defaultDensity,
    this.onPressed,
    this.icon,
  }) : _indicator = null,
       tinted = null;

  /// Creates an [OudsLink] displaying its [label] alongside a custom [linkIcon].
  const OudsLink.icon({
    super.key,
    required this.label,
    required this.icon,
    this.size = OudsLinkSize.defaultSize,
    this.density = OudsLinkDensity.defaultDensity,
    this.onPressed,
    this.tinted = true,
  }) : _indicator = null,
       layout = OudsLinkLayout.textAndIcon;

  /// Creates an [OudsLink] used for "backward" navigation, displaying a
  /// leading chevron before the [label].
  const OudsLink.previous({
    super.key,
    required this.label,
    this.size = OudsLinkSize.defaultSize,
    this.density = OudsLinkDensity.defaultDensity,
    this.onPressed,
  }) : icon = null,
       tinted = null,
       _indicator = OudsLinkIndicator.previous,
       layout = OudsLinkLayout.back;

  /// Creates an [OudsLink] used for standard navigation, displaying a
  /// trailing chevron after the [label].
  const OudsLink.next({
    super.key,
    required this.label,
    this.size = OudsLinkSize.defaultSize,
    this.density = OudsLinkDensity.defaultDensity,
    this.onPressed,
  }) : icon = null,
       tinted = null,
       _indicator = OudsLinkIndicator.next,
       layout = OudsLinkLayout.next;

  /// Creates an [OudsLink] navigating outside the current product, service or
  /// application, displaying a trailing external indicator after the [label].
  const OudsLink.external({
    super.key,
    required this.label,
    this.size = OudsLinkSize.defaultSize,
    this.density = OudsLinkDensity.defaultDensity,
    this.onPressed,
  }) : icon = null,
       tinted = null,
       _indicator = OudsLinkIndicator.external,
       layout = OudsLinkLayout.next;

  @override
  State<OudsLink> createState() => _OudsLinkState();
}

class _OudsLinkState extends State<OudsLink> {
  bool isSingleLine = true;
  late FocusNode _focusNode;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() => _handleFocusChange(_focusNode.hasFocus));
    // After the initial layout phase, measure the rendered text
    // to determine whether it fits on one line or wraps to multiple lines.
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkTextLines());
  }

  @override
  void didUpdateWidget(covariant OudsLink oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the text label has changed, schedule a check after the next frame.
    // This ensures the widget re-measures how many lines the text occupies
    // and adjusts the icon’s vertical alignment accordingly
    // (centered for a single-line label, bottom-aligned otherwise).
    if (oldWidget.label != widget.label) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkTextLines());
    }
  }

  /// Dynamically measures how many lines the rendered text occupies.
  ///
  /// This method uses a [TextPainter] to calculate the actual text layout
  /// based on the available width. The result updates the [isSingleLine] state,
  /// which is used to control the vertical alignment of the icon
  /// within the surrounding [Row].
  void _checkTextLines() {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !mounted) return;

    final availableWidth = renderBox.size.width == 0
        ? double.infinity
        : renderBox.size.width;
    final labelText = TextPainter(
      text: TextSpan(text: widget.label),
      textDirection: Directionality.of(context),
      maxLines: null,
    );
    labelText.layout(maxWidth: availableWidth);
    final lineCount = labelText.computeLineMetrics().length;

    setState(() {
      isSingleLine = lineCount == 1;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool focus) {
    if (widget.onPressed == null) _isFocused = false;
    setState(() => _isFocused = focus);
  }

  Widget _buildLinkContent(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final interactionModelHover = OudsInheritedInteractionModel.of(
      context,
      InteractionAspect.hover,
    );
    final interactionModelPressed = OudsInheritedInteractionModel.of(
      context,
      InteractionAspect.pressed,
    );
    final isHovered = interactionModelHover?.state.isHovered ?? false;
    final isPressed = interactionModelPressed?.state.isPressed ?? false;

    final linkStateDeterminer = OudsLinkControlStateDeterminer(
      enabled: !isDisabled,
      isPressed: _isPressed || isPressed,
      isHovered: isHovered || _isHovered,
      isFocused: _isFocused,
    );

    final linkControlState = linkStateDeterminer.determineControlState();
    final linkStatusModifier = OudsLinkStatusModifier(context);
    final linkSizeModifier = OudsLinkSizeModifier(context);
    final linkTextStyleModifier = OudsLinkTextStyleModifier(context);

    //case link with text only
    if (widget._indicator == null &&
        widget.icon == null &&
        widget.layout == OudsLinkLayout.textOnly) {
      return _buildLabelText(
        linkControlState,
        linkStatusModifier,
        linkTextStyleModifier,
      );
      //case link with text and icon
    } else if ((widget._indicator == null && widget.icon != null) ||
        (widget._indicator != null &&
            widget._indicator == OudsLinkIndicator.previous)) {
      return _getTextIconOrPreviousContent(
        linkControlState,
        linkStatusModifier,
        linkTextStyleModifier,
        linkSizeModifier,
      );
    } else if (widget._indicator != null &&
        widget._indicator != OudsLinkIndicator.previous) {
      return getNextOrExternalContent(
        linkControlState,
        linkStatusModifier,
        linkTextStyleModifier,
        linkSizeModifier,
      );
      //deprecated enum , will be removed
    } else {
      switch (widget.layout) {
        case OudsLinkLayout.textOnly:
          return _buildLabelText(
            linkControlState,
            linkStatusModifier,
            linkTextStyleModifier,
          );
        case OudsLinkLayout.next:
          return getNextOrExternalContent(
            linkControlState,
            linkStatusModifier,
            linkTextStyleModifier,
            linkSizeModifier,
          );
        case OudsLinkLayout.back:
        case OudsLinkLayout.textAndIcon:
          return _getTextIconOrPreviousContent(
            linkControlState,
            linkStatusModifier,
            linkTextStyleModifier,
            linkSizeModifier,
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final linkSizeModifier = OudsLinkSizeModifier(context);

    /// Builds the main link container with proper constraints
    return Semantics(
      enabled: !isDisabled,
      link: true,
      // the link role is not read by talkback so we define it in value
      value: defaultTargetPlatform == TargetPlatform.android
          ? OudsLocalizations.of(context)?.core_link_trait_a11y
          : null,
      child: _buildLinkContainer(
        context,
        child: _buildLinkContent(context),
        linkSizeModifier: linkSizeModifier,
        isDisabled: isDisabled,
      ),
    );
  }

  /// Returns the [Text] widget shared by every layout, applying the
  /// appropriate text style, color and decoration based on the link state.
  Widget _buildLabelText(
    OudsLinkControlState linkControlState,
    OudsLinkStatusModifier linkStatusModifier,
    OudsLinkTextStyleModifier linkTextStyleModifier,
  ) {
    final textAndIconColor = linkStatusModifier.getTextAndIconColor(
      linkControlState,
    );
    return Text(
      widget.label,
      textAlign: TextAlign.left,
      style: linkTextStyleModifier
          .buildLinkTextStyle(size: widget.size)
          .copyWith(
            color: textAndIconColor,
            decoration: linkTextStyleModifier.getTextDecorationStatus(
              linkControlState,
              (widget._indicator == null && widget.icon == null) ||
                  widget.layout == OudsLinkLayout.textOnly,
            ),
            decorationColor: textAndIconColor,
          ),
    );
  }

  /// Returns a Row widget for a link with `next` layout, including the label
  /// and a next icon of a link component.
  Widget getNextOrExternalContent(
    OudsLinkControlState linkControlState,
    OudsLinkStatusModifier linkStatusModifier,
    OudsLinkTextStyleModifier linkTextStyleModifier,
    OudsLinkSizeModifier linkSizeModifier,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isSingleLine
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.end,
      spacing: linkSizeModifier.getSizeColumnGap(
        widget.size,
        widget.layout,
        widget._indicator,
        widget.icon,
      )!,
      children: [
        Flexible(
          child: _buildLabelText(
            linkControlState,
            linkStatusModifier,
            linkTextStyleModifier,
          ),
        ),
        _buildIcon(
          context,
          widget.icon,
          linkControlState,
          widget.layout,
          widget.size,
          widget._indicator,
        ),
      ],
    );
  }

  /// Returns a Row widget for a link with `textAndIcon` or `back` layout,
  /// including the icon and label, properly aligned and spaced.
  Widget _getTextIconOrPreviousContent(
    OudsLinkControlState linkControlState,
    OudsLinkStatusModifier linkStatusModifier,
    OudsLinkTextStyleModifier linkTextStyleModifier,
    OudsLinkSizeModifier linkSizeModifier,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: linkSizeModifier.getSizeColumnGap(
        widget.size,
        widget.layout,
        widget._indicator,
        widget.icon,
      )!,
      children: [
        //the deprecated param will be removed
        if (widget.layout == OudsLinkLayout.back ||
            widget.layout == OudsLinkLayout.textAndIcon ||
            widget._indicator == OudsLinkIndicator.previous ||
            widget.icon != null)
          _buildIcon(
            context,
            widget.icon,
            linkControlState,
            widget.layout,
            widget.size,
            widget._indicator,
          ),
        Flexible(
          child: _buildLabelText(
            linkControlState,
            linkStatusModifier,
            linkTextStyleModifier,
          ),
        ),
      ],
    );
  }

  Widget _buildLinkContainer(
    BuildContext context, {
    required Widget child,
    required OudsLinkSizeModifier linkSizeModifier,
    required bool isDisabled,
  }) {
    final minHeightAndWidth = linkSizeModifier.getMinWidthAndHeight(
      widget.size,
      widget.density,
    );

    final theme = OudsTheme.of(context);
    final colorScheme = theme.colorScheme(context);
    final borderTokens = theme.borderTokens;

    return Container(
      constraints: BoxConstraints(
        minHeight: minHeightAndWidth[OudsLinkDimensions.height.name]!,
        minWidth: minHeightAndWidth[OudsLinkDimensions.width.name]!,
      ),
      padding: linkSizeModifier.getPadding(widget.size, widget.density),
      decoration: _isFocused
          ? BoxDecoration(
              border: OudsBorder().borderAll(
                width: borderTokens.widthFocusInset,
                color: colorScheme.borderFocusInset,
              ),
            )
          : null,
      child: InkWell(
        onTap: widget.onPressed,
        focusNode: _focusNode,
        canRequestFocus: !isDisabled,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (hovering) {
          if (!isDisabled) setState(() => _isHovered = hovering);
        },
        onHighlightChanged: (highlighted) {
          if (!isDisabled) setState(() => _isPressed = highlighted);
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (_isFocused)
              Positioned(
                top: -borderTokens.widthFocus,
                bottom: -borderTokens.widthFocus,
                left: -borderTokens.widthFocus,
                right: -borderTokens.widthFocus,
                child: Container(
                  decoration: BoxDecoration(
                    border: OudsBorder().borderAll(
                      color: colorScheme.borderFocus,
                      width: borderTokens.widthFocus,
                    ),
                  ),
                ),
              ),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(
    BuildContext context,
    String? assetName,
    OudsLinkControlState controlItemState,
    OudsLinkLayout layout,
    OudsLinkSize size,
    OudsLinkIndicator? indicator,
  ) {
    final statusModifier = OudsLinkStatusModifier(context);
    final sizeModifier = OudsLinkSizeModifier(context);
    final iconSize = sizeModifier.getIconSize(size);
    final isIcon =
        assetName != null ||
        layout == OudsLinkLayout.textAndIcon ||
        widget.icon != null;

    return SvgPicture.asset(
      excludeFromSemantics: true,
      assetName ?? _getIcon(layout, indicator)!,
      package: assetName == null ? OudsTheme.of(context).packageName : null,
      width: iconSize[OudsLinkDimensions.width.name],
      height: iconSize[OudsLinkDimensions.height.name],
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        !isIcon
            ? statusModifier.getArrowColor(controlItemState)
            : statusModifier.getTextAndIconColor(controlItemState),
        BlendMode.srcIn,
      ),
      matchTextDirection: true,
    );
  }

  /// Return the icon based on link layout
  String? _getIcon(OudsLinkLayout layout, OudsLinkIndicator? indicator) {
    //new API
    if (indicator != null) {
      switch (indicator) {
        case OudsLinkIndicator.next:
          return AppAssets.icons.componentLinkNext;
        case OudsLinkIndicator.previous:
          return AppAssets.icons.componentLinkPrevious;
        case OudsLinkIndicator.external:
          return AppAssets.icons.componentLinkExternal;
      }
    }
    //old API
    switch (layout) {
      case OudsLinkLayout.textOnly:
        throw UnimplementedError("Error status for textOnly is not relevant");
      case OudsLinkLayout.textAndIcon:
        throw UnimplementedError(
          "Error status for textAndIcon is not relevant",
        ); // it will be implemented from user
      case OudsLinkLayout.next:
        return AppAssets.icons.componentLinkNext;
      case OudsLinkLayout.back:
        return AppAssets.icons.componentLinkPrevious;
    }
  }
}
