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

/// {@category List item}
library;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_background_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_foreground_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading_widget.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing_widget.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/scheme/typography/ouds_typography.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_listItem_tokens.dart';

// Re-export shared types so callers only need to import this file.
export 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';

// ---------------------------------------------------------------------------
// Size & alignment
// ---------------------------------------------------------------------------

/// Represents the size of an [OudsListItem].
enum OudsListItemSize {
  /// Standard size with default minimum height and padding.
  ///
  /// Dart equivalent of Kotlin `Default` (`default` is a reserved keyword in Dart).
  defaultSize,

  /// Compact size with reduced minimum height and padding.
  smallSize,
}

/// Represents the vertical alignment of an [OudsListItem] content.
enum OudsListItemContentAlignment {
  /// Content is vertically centered within the row.
  center,

  /// Content is aligned to the top of the row.
  top,
}

// ---------------------------------------------------------------------------
// Defaults
// ---------------------------------------------------------------------------

/// Default values for [OudsListItem].
class OudsListItemDefaults {
  OudsListItemDefaults._();

  /// Default content alignment of an [OudsListItem].
  static const contentAlignment = OudsListItemContentAlignment.center;

  /// Default navigation indicator of an [OudsListItem].
  static const OudsListItemIndicator indicator = OudsListItemIndicatorNext();

  /// Default decoration of an [OudsListItem].
  static const OudsListItemDecoration decoration = OudsListItemDecorationNone();
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

/// A list item component that displays a row of information within a list.
///
/// **Static variant** — set only [label] and optional fields; no [onTap]:
/// ```dart
/// OudsListItem(
///   label: 'Title',
///   description: 'Secondary text',
///   leading: OudsListItemLeadingIcon(Neutral()),
/// )
/// ```
///
/// **Navigation variant** — provide [onTap] (and optionally [indicator]):
/// ```dart
/// OudsListItem(
///   label: 'Navigate',
///   onTap: () => Navigator.of(context).push(…),
///   indicator: const OudsListItemIndicatorNext(),
/// )
/// ```
class OudsListItem extends StatefulWidget {
  final OudsListItemSize size;
  final String label;
  final OudsListItemContentAlignment contentAlignment;
  final String? overline;
  final String? extraLabel;
  final String? description;
  final OudsListItemLeading? leading;
  final OudsListItemTrailing? trailing;

  /// Decoration controlling the background and/or border of this item.
  ///
  /// Use [OudsListItemDecorationNone] (default) for a plain divider-only item,
  /// [OudsListItemDecorationBackground] for a persistently highlighted item,
  /// [OudsListItemDecorationOutlined] for a bordered item, etc.
  final OudsListItemDecoration decoration;

  final String? helperText;
  final bool boldLabel;
  final bool enable;

  /// Callback invoked when the item is tapped.
  ///
  /// When non-null the item becomes a **navigation item**: it gains an
  /// [indicator] chevron and forwards taps to this callback.
  final VoidCallback? onTap;

  /// Navigation indicator shown when [onTap] is provided.
  ///
  /// - [OudsListItemIndicatorPrevious] is rendered at the **start** of the row.
  /// - [OudsListItemIndicatorNext] and [OudsListItemIndicatorExternal] are
  ///   rendered at the **end** of the row.
  ///
  /// Ignored when [onTap] is `null`. Defaults to [OudsListItemDefaults.indicator].
  final OudsListItemIndicator indicator;

  const OudsListItem({
    super.key,
    required this.label,
    this.size = OudsListItemSize.defaultSize,
    this.contentAlignment = OudsListItemDefaults.contentAlignment,
    this.overline,
    this.extraLabel,
    this.description,
    this.leading,
    this.trailing,
    this.decoration = OudsListItemDefaults.decoration,
    this.helperText,
    this.boldLabel = false,
    this.enable = true,
    this.onTap,
    this.indicator = OudsListItemDefaults.indicator,
  });

  @override
  State<OudsListItem> createState() => _OudsListItemState();
}

class _OudsListItemState extends State<OudsListItem> {
  @override
  Widget build(BuildContext context) {
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

    final oudsTheme = OudsTheme.of(context);
    final listItemTokens = oudsTheme.componentsTokens(context).listItem;
    final controlItemTokens = oudsTheme.componentsTokens(context).controlItem;
    final typographyTokens = oudsTheme.typographyTokens;

    final listItemState = OudsListItemControlStateDeterminer(
      enabled: widget.enable,
      isPressed: isPressed,
      isHovered: isHovered,
    ).determineControlState();

    final contentColor = OudsListItemForegroundModifier(
      context,
    ).contentColor(widget.enable);
    final mutedColor = OudsListItemForegroundModifier(
      context,
    ).mutedColor(widget.enable);
    final backgroundColor = OudsListItemBackgroundModifier(
      context,
    ).getBackgroundColor(listItemState, widget.decoration);

    final indicatorColor = _indicatorColor(context, listItemState);
    final indicatorSize = controlItemTokens.sizeAssetSmall;

    final isNavigationItem = widget.onTap != null;
    final showPreviousIndicator =
        isNavigationItem && widget.indicator is OudsListItemIndicatorPrevious;
    final showEndIndicator =
        isNavigationItem && widget.indicator is! OudsListItemIndicatorPrevious;

    final verticalPadding = _verticalPadding(listItemTokens);

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: listItemTokens.sizeMinWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            button: isNavigationItem,
            enabled: widget.enable,
            child: GestureDetector(
              onTap: widget.enable ? widget.onTap : null,
              child: Container(
                color: backgroundColor,
                constraints: BoxConstraints(
                  minHeight: _minHeight(listItemTokens),
                ),
                padding: EdgeInsets.only(
                  top: verticalPadding.top,
                  bottom: verticalPadding.bottom,
                  left: listItemTokens.spacePaddingInline,
                  right: listItemTokens.spacePaddingInline,
                ),
                child: Row(
                  crossAxisAlignment: _rowCrossAxisAlignment(),
                  children: [
                    // Previous indicator at the start of the row.
                    if (showPreviousIndicator) ...[
                      _buildIndicatorWidget(
                        widget.indicator,
                        indicatorColor,
                        indicatorSize,
                        oudsTheme.packageName,
                      ),
                      SizedBox(width: listItemTokens.spaceColumnGap),
                    ],

                    // Leading slot.
                    if (widget.leading != null) ...[
                      OudsListItemLeadingWidget(
                        leading: widget.leading!,
                        enable: widget.enable,
                      ),
                      SizedBox(width: listItemTokens.spaceColumnGap),
                    ],

                    // Main content (expands to fill available space).
                    Expanded(
                      child: _buildContent(
                        context,
                        typographyTokens,
                        contentColor,
                        mutedColor,
                      ),
                    ),

                    // Trailing slot.
                    if (widget.trailing != null) ...[
                      SizedBox(width: listItemTokens.spaceColumnGap),
                      OudsListItemTrailingWidget(
                        trailing: widget.trailing!,
                        enable: widget.enable,
                      ),
                    ],

                    // Next / External indicator at the end of the row.
                    if (showEndIndicator) ...[
                      SizedBox(width: listItemTokens.spaceColumnGap),
                      _buildIndicatorWidget(
                        widget.indicator,
                        indicatorColor,
                        indicatorSize,
                        oudsTheme.packageName,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Bottom divider.
          if (widget.decoration.divider) OudsDivider.horizontal(),

          // Helper text below the row.
          if (widget.helperText != null && widget.helperText!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                top: listItemTokens.spacePaddingBlockTopHelperText,
                left: listItemTokens.spacePaddingInline,
                right: listItemTokens.spacePaddingInline,
              ),
              child: Text(
                widget.helperText!,
                style: typographyTokens
                    .typeLabelDefaultMedium(context)
                    .copyWith(color: mutedColor),
              ),
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Content column
  // -------------------------------------------------------------------------

  Widget _buildContent(
    BuildContext context,
    OudsTypography typographyTokens,
    Color contentColor,
    Color mutedColor,
  ) {
    return Column(
      mainAxisAlignment: _contentMainAxisAlignment(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.overline != null)
          Text(
            widget.overline!,
            style: typographyTokens
                .typeLabelModerateSmall(context)
                .copyWith(color: mutedColor),
          ),
        Text(
          widget.label,
          style:
              (widget.boldLabel
                      ? typographyTokens.typeLabelStrongLarge(context)
                      : typographyTokens.typeLabelDefaultLarge(context))
                  .copyWith(color: contentColor),
        ),
        if (widget.extraLabel != null && widget.extraLabel!.isNotEmpty)
          Text(
            widget.extraLabel!,
            style: typographyTokens
                .typeLabelStrongMedium(context)
                .copyWith(color: contentColor),
          ),
        if (widget.description != null && widget.description!.isNotEmpty)
          Text(
            widget.description!,
            style: typographyTokens
                .typeLabelDefaultMedium(context)
                .copyWith(color: mutedColor),
          ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Indicator
  // -------------------------------------------------------------------------

  Widget _buildIndicatorWidget(
    OudsListItemIndicator indicator,
    Color color,
    double size,
    String packageName,
  ) {
    return switch (indicator) {
      OudsListItemIndicatorNext() => SvgPicture.asset(
        AppAssets.icons.componentLinkNext,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        package: packageName,
        excludeFromSemantics: true,
      ),
      OudsListItemIndicatorPrevious() => SvgPicture.asset(
        AppAssets.icons.componentLinkPrevious,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        package: packageName,
        excludeFromSemantics: true,
      ),
      OudsListItemIndicatorExternal() => Icon(
        Icons.open_in_new,
        size: size,
        color: color,
      ),
    };
  }

  Color _indicatorColor(BuildContext context, OudsListItemControlState state) {
    final colorScheme = OudsTheme.of(context).colorScheme(context);
    final linkTokens = OudsTheme.of(context).componentsTokens(context).link;
    return switch (state) {
      OudsListItemControlState.enabled => linkTokens.colorChevronEnabled,
      OudsListItemControlState.focused => colorScheme.actionFocus,
      OudsListItemControlState.hovered => colorScheme.actionHover,
      OudsListItemControlState.pressed => colorScheme.actionPressed,
      OudsListItemControlState.disabled => colorScheme.actionDisabled,
    };
  }

  // -------------------------------------------------------------------------
  // Layout helpers
  // -------------------------------------------------------------------------

  double _minHeight(OudsListItemTokens tokens) => switch (widget.size) {
    OudsListItemSize.defaultSize => tokens.sizeMinHeightDefault,
    OudsListItemSize.smallSize => tokens.sizeMinHeightSmall,
  };

  CrossAxisAlignment _rowCrossAxisAlignment() =>
      switch (widget.contentAlignment) {
        OudsListItemContentAlignment.center => CrossAxisAlignment.center,
        OudsListItemContentAlignment.top => CrossAxisAlignment.start,
      };

  MainAxisAlignment _contentMainAxisAlignment() =>
      switch (widget.contentAlignment) {
        OudsListItemContentAlignment.center => MainAxisAlignment.center,
        OudsListItemContentAlignment.top => MainAxisAlignment.start,
      };

  /// Returns the top and bottom padding for the row, applying the
  /// top-alignment counterweight when [contentAlignment] is [top].
  ({double top, double bottom}) _verticalPadding(OudsListItemTokens tokens) {
    return switch (widget.size) {
      OudsListItemSize.defaultSize => switch (widget.contentAlignment) {
        OudsListItemContentAlignment.center => (
          top: tokens.spacePaddingBlockDefault,
          bottom: tokens.spacePaddingBlockDefault,
        ),
        OudsListItemContentAlignment.top => (
          top: tokens.spacePaddingBlockTopAlignmentTopCounterweightDefault,
          bottom: tokens.spacePaddingBlockDefault,
        ),
      },
      OudsListItemSize.smallSize => switch (widget.contentAlignment) {
        OudsListItemContentAlignment.center => (
          top: tokens.spacePaddingBlockSmall,
          bottom: tokens.spacePaddingBlockSmall,
        ),
        OudsListItemContentAlignment.top => (
          top: tokens.spacePaddingBlockTopAlignmentTopCounterweightSmall,
          bottom: tokens.spacePaddingBlockSmall,
        ),
      },
    };
  }
}
