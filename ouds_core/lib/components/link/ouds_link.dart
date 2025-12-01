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

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ouds_core/components/common/OudsBorder.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/link/internal/ouds_link_control_state.dart';
import 'package:ouds_core/components/link/internal/ouds_link_size_modifier.dart';
import 'package:ouds_core/components/link/internal/ouds_link_status_modifier.dart';
import 'package:ouds_core/components/link/internal/ouds_link_text_style_modifier.dart';
import 'package:ouds_core/l10n/gen/ouds_localizations.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

///The [OudsLinkLayout] defines the layout of the link’s content.
/// This enum controls whether the link displays text, text and icon, back or next
enum OudsLinkLayout {
  textOnly,
  textAndIcon,
  back,
  next;
}

/// The [OudsLinkSize] defines the link's visual size.
enum OudsLinkSize {
  defaultSize,
  small;
}

/// [OUDS Link design guidelines](https://unified-design-system.orange.com/472794e18/p/31c33b-link)
///
/// **Reference design version : 2.2.0**
///
/// A link is a user interface element that allows navigation from one location to another,
/// either within the same page, across different pages of a site (or application), or to an external resource.
/// Typically rendered as underlined or styled text,
/// a link communicates its interactive nature visually and semantically.
/// It should always lead to a valid destination and be clearly labeled to describe the target or purpose.
/// Unlike a button, which triggers an action, a link’s primary function is navigation.
///
///
/// parameters :
/// - [size] : The size of the link, [OudsLinkSize] such as small or default, to fit various visual needs.
/// - [label] : A text to display in link component.
/// - [icon] : An optional SVG asset name to display an icon within the link.
/// - [layout]: Defines the layout to be used for the link [OudsLinkLayout].
/// - [onPressed]: Callback invoked when the link is clicked.
///
///
/// ### You can use [OudsLink] component in your project, customizing parameters as needed :
///
/// **Small Text only link :**
///
/// This is the default layout of the component.

/// ```dart
/// OudsLink(
///       label: 'Label',
///       size: OudsLinkSize.small,
///       onPressed: () {}
///     );
/// ```
///
/// ### Small Next link :
/// This is the default layout of the component.
/// ```dart
/// OudsLink(
///       label: 'Label',
///       size: OudsLinkSize.small,
///       layout : OudsLinkayout.next
///       onPressed: () {}
///     );
/// ```
///
/// ### Default link with Icon :
/// This is the default layout of the component.
/// ```dart
/// OudsLink(
///       label: 'Label',
///       layout : OudsLinkayout.textAndIcon
///       icon : 'assets/ic_heart.svg'
///       onPressed: () {}
///     );
/// ```
///
///
class OudsLink extends StatefulWidget {
  final String label;
  final String? icon;
  final OudsLinkLayout layout;
  final OudsLinkSize? size;
  final VoidCallback? onPressed;

  const OudsLink({
    super.key,
    required this.label,
    this.icon,
    this.layout = OudsLinkLayout.textOnly,
    this.size = OudsLinkSize.defaultSize,
    this.onPressed,
  }) : assert(
          layout != OudsLinkLayout.textAndIcon || icon != null,
          'icon is required when layout is textAndIcon',
        );

  static Widget buildIcon(
    BuildContext context,
    String? assetName,
    OudsLinkControlState controlItemState,
    OudsLinkLayout layout,
    OudsLinkSize size,
  ) {
    final statusModifier = OudsLinkStatusModifier(context);
    final sizeModifier = OudsLinkSizeModifier(context);
    final iconSize = sizeModifier.getIconSize(size);
    final isIcon = layout == OudsLinkLayout.textAndIcon;
    final rtlMode = Directionality.of(context) == TextDirection.rtl;

    return SvgPicture.asset(
      excludeFromSemantics: true,
      assetName ?? statusModifier.getStatusIcon(layout, rtlMode)!,
      package: assetName == null ? OudsTheme.of(context).packageName : null,
      width: iconSize[OudsLinkDimensions.width.name],
      height: iconSize[OudsLinkDimensions.height.name],
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        !isIcon ? statusModifier.getArrowColor(controlItemState) : statusModifier.getTextAndIconColor(controlItemState),
        BlendMode.srcIn,
      ),
    );
  }

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
    _focusNode = FocusNode()..addListener(() => _handleFocusChange(_focusNode.hasFocus));
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

    final availableWidth = renderBox.size.width == 0 ? double.infinity : renderBox.size.width;
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

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final interactionModelHover = OudsInheritedInteractionModel.of(context, InteractionAspect.hover);
    final interactionModelPressed = OudsInheritedInteractionModel.of(context, InteractionAspect.pressed);
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

    Widget content;

    switch (widget.layout) {
      case OudsLinkLayout.textOnly:
        content = getTextOnlyContent(linkControlState, linkStatusModifier, linkTextStyleModifier);
        break;
      case OudsLinkLayout.next:
        content = getNextContent(linkControlState, linkStatusModifier, linkTextStyleModifier, linkSizeModifier);
        break;
      case OudsLinkLayout.back:
      case OudsLinkLayout.textAndIcon:
        content = getTextIconOrBackContent(linkControlState, linkStatusModifier, linkTextStyleModifier, linkSizeModifier);
        break;
    }

    /// Builds the main link container with proper constraints
    return Semantics(
      enabled: !isDisabled,
      hint: OudsLocalizations.of(context)?.core_link_link_label_a11y,
      child: _buildLinkContainer(
        context,
        child: content,
        linkSizeModifier: linkSizeModifier,
        isDisabled: isDisabled,
      ),
    );
  }

  /// Returns a Text widget for a link with `textOnly` layout,
  /// applying the appropriate text style and color based on the link state.
  Widget getTextOnlyContent(OudsLinkControlState linkControlState, OudsLinkStatusModifier linkStatusModifier, OudsLinkTextStyleModifier linkTextStyleModifier) {
    return Text(
      widget.label,
      textAlign: TextAlign.left,
      style: linkTextStyleModifier.buildLinkTextStyle(context, size: widget.size!).copyWith(
            color: linkStatusModifier.getTextAndIconColor(linkControlState),
            decoration: linkTextStyleModifier.getTextDecorationStatus(linkControlState, widget.layout),
            decorationColor: linkStatusModifier.getTextAndIconColor(linkControlState),
          ),
    );
  }

  /// Returns a Row widget for a link with `next` layout, including the label
  /// and a next icon of a link component.
  Widget getNextContent(OudsLinkControlState linkControlState, OudsLinkStatusModifier linkStatusModifier, OudsLinkTextStyleModifier linkTextStyleModifier, OudsLinkSizeModifier linkSizeModifier) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isSingleLine ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      spacing: linkSizeModifier.getSizeColumnGap(widget.size, widget.layout)!,
      children: [
        Flexible(
            child: Text(
          widget.label,
          textAlign: TextAlign.left,
          style: linkTextStyleModifier.buildLinkTextStyle(context, size: widget.size!).copyWith(
                color: linkStatusModifier.getTextAndIconColor(linkControlState),
                decoration: linkTextStyleModifier.getTextDecorationStatus(linkControlState, widget.layout),
                decorationColor: linkStatusModifier.getTextAndIconColor(linkControlState),
              ),
        )),
        OudsLink.buildIcon(context, widget.icon, linkControlState, widget.layout, widget.size!),
      ],
    );
  }

  /// Returns a Row widget for a link with `textAndIcon` or `back` layout,
  /// including the icon and label, properly aligned and spaced.
  Widget getTextIconOrBackContent(OudsLinkControlState linkControlState, OudsLinkStatusModifier linkStatusModifier, OudsLinkTextStyleModifier linkTextStyleModifier, OudsLinkSizeModifier linkSizeModifier) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: linkSizeModifier.getSizeColumnGap(widget.size, widget.layout)!,
      children: [
        if (widget.layout == OudsLinkLayout.back || widget.layout == OudsLinkLayout.textAndIcon) OudsLink.buildIcon(context, widget.icon, linkControlState, widget.layout, widget.size!),
        Flexible(
            child: Text(
          widget.label,
          textAlign: TextAlign.left,
          style: linkTextStyleModifier.buildLinkTextStyle(context, size: widget.size!).copyWith(
                color: linkStatusModifier.getTextAndIconColor(linkControlState),
                decoration: linkTextStyleModifier.getTextDecorationStatus(linkControlState, widget.layout),
                decorationColor: linkStatusModifier.getTextAndIconColor(linkControlState),
              ),
        )),
      ],
    );
  }

  Widget _buildLinkContainer(
    BuildContext context, {
    required Widget child,
    required OudsLinkSizeModifier linkSizeModifier,
    required bool isDisabled,
  }) {
    final minHeightAndWidth = linkSizeModifier.getMinWidthAndHeight(widget.size);

    return Container(
      constraints: BoxConstraints(
        minHeight: minHeightAndWidth[OudsLinkDimensions.height.name]!,
        minWidth: minHeightAndWidth[OudsLinkDimensions.width.name]!,
      ),
      decoration: _isFocused
          ? BoxDecoration(
              border: OudsBorder().borderAll(
                width: OudsTheme.of(context).borderTokens.widthFocusInset,
                color: OudsTheme.of(context).colorScheme(context).borderFocusInset,
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
                top: -OudsTheme.of(context).borderTokens.widthFocus,
                bottom: -OudsTheme.of(context).borderTokens.widthFocus,
                left: -OudsTheme.of(context).borderTokens.widthFocus,
                right: -OudsTheme.of(context).borderTokens.widthFocus,
                child: Container(
                  decoration: BoxDecoration(
                    border: OudsBorder().borderAll(
                      color: OudsTheme.of(context).colorScheme(context).borderFocus,
                      width: OudsTheme.of(context).borderTokens.widthFocus,
                    ),
                  ),
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: OudsTheme.of(context).componentsTokens(context).link.spacePaddingBlock,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
