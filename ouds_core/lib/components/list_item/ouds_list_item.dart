// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components

/// {@category List item}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_asset_builder.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_background_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_foreground_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_indicator_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/utilities/app_assets.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/scheme/typography/ouds_typography.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_listItem_tokens.dart';

// ---------------------------------------------------------------------------
// Size & alignment
// ---------------------------------------------------------------------------

/// Represents the size of an [OudsListItem].
enum OudsListItemSize {
  /// Standard size with default minimum height and padding.
  ///
  /// (`default` is a reserved keyword in Dart, so we use `defaultSize`.)
  defaultSize,

  /// Compact size with reduced minimum height and padding.
  smallSize,
}

/// Vertical alignment of content inside an [OudsListItem].
enum OudsListItemContentAlignment {
  /// Content is vertically centered within the row.
  center,

  /// Content is aligned to the top of the row.
  top,
}

// ---------------------------------------------------------------------------
// Defaults
// ---------------------------------------------------------------------------

/// Default values for [OudsListItem] constructor parameters.
class OudsListItemDefaults {
  OudsListItemDefaults._();

  /// Default content alignment.
  static const contentAlignment = OudsListItemContentAlignment.center;

  /// Default navigation indicator (chevron pointing right).
  static const OudsListItemIndicator indicator = OudsListItemIndicatorNext();
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

/// A list item component that displays a row of information within a list.
///
/// Mirrors Flutter's [ListTile] spirit — leading / label / trailing — but uses
/// OUDS design tokens, interaction states and an optional navigation indicator.
///
/// **Static variant** — no [onTap], displays read-only information:
/// ```dart
/// OudsListItem(
///   label: 'Title',
///   description: 'Secondary text',
///   leading: OudsListItemLeadingIcon(Neutral(icon: 'assets/star.svg')),
///   background: true,
/// )
/// ```
///
/// **Navigation variant** — provide [onTap] to make the item interactive:
/// ```dart
/// OudsListItem(
///   label: 'Navigate',
///   onTap: () => Navigator.of(context).push(…),
///   indicator: const OudsListItemIndicatorNext(),
/// )
/// ```
class OudsListItem extends StatefulWidget {
  /// The mandatory main label displayed in the center column.
  final String label;

  /// Size variant. Defaults to [OudsListItemSize.defaultSize].
  final OudsListItemSize size;

  /// Vertical alignment of all slots. Defaults to [OudsListItemContentAlignment.center].
  final OudsListItemContentAlignment contentAlignment;

  /// Optional text displayed above [label] in a smaller, muted style.
  final String? overline;

  /// Optional strong accompanying label displayed between [label] and [description].
  final String? extraLabel;

  /// Optional secondary text displayed below [label] / [extraLabel].
  final String? description;

  /// Optional content at the start of the row (icon, image, avatar, flag …).
  final OudsListItemLeading? leading;

  /// Optional content at the end of the row (icon, image, text, badge, tag …).
  final OudsListItemTrailing? trailing;

  /// Whether a horizontal divider is drawn below the item. Defaults to `true`.
  final bool divider;

  /// Whether the item has a persistent background color. Defaults to `false`.
  ///
  /// Set to `true` for static (non-clickable) items — matches the Android default
  /// for [OudsSmallListItem] in its static variant.
  final bool background;

  /// Optional helper text displayed below the row (and below the divider).
  final String? helperText;

  /// Whether [label] is rendered in bold. Defaults to `false`.
  final bool boldLabel;

  /// Whether the item is interactive. Defaults to `true`.
  ///
  /// When `false`, all content is rendered in its disabled appearance and
  /// [onTap] is ignored.
  final bool enable;

  /// Callback invoked when the item is tapped.
  ///
  /// When non-null the item becomes a **navigation item** — it gains an
  /// [indicator] chevron and forwards taps to this callback.
  final VoidCallback? onTap;

  /// Navigation indicator shown when [onTap] is provided.
  ///
  /// - [OudsListItemIndicatorPrevious] — chevron at the **start** of the row.
  /// - [OudsListItemIndicatorNext] / [OudsListItemIndicatorExternal] — icon at the **end**.
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
    this.divider = true,
    this.background = false,
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
    // Read hover / press state from the inherited interaction model.
    final isHovered =
        OudsInheritedInteractionModel.of(
          context,
          InteractionAspect.hover,
        )?.state.isHovered ??
        false;
    final isPressed =
        OudsInheritedInteractionModel.of(
          context,
          InteractionAspect.pressed,
        )?.state.isPressed ??
        false;

    final oudsTheme = OudsTheme.of(context);
    final tokens = oudsTheme.componentsTokens(context).listItem;
    final typography = oudsTheme.typographyTokens;

    // Map the public `background` + `divider` flags to the internal decoration
    // type, mirroring the Android approach (background: Boolean / divider: Boolean).
    final decoration = widget.background
        ? OudsListItemDecorationBackground(divider: widget.divider)
        : OudsListItemDecorationNone(divider: widget.divider);

    // Resolve the interaction state (disabled takes priority over everything).
    final state = OudsListItemControlStateDeterminer(
      enabled: widget.enable,
      isPressed: isPressed,
      isHovered: isHovered,
    ).determineControlState();

    // Resolve foreground colors once — reused in the content column and helper text.
    final foreground = OudsListItemForegroundModifier(context);
    final contentColor = foreground.contentColor(widget.enable);
    final mutedColor = foreground.mutedColor(widget.enable);

    // Indicator placement: Previous → start, Next/External → end.
    final showPreviousIndicator =
        widget.onTap != null &&
        widget.indicator is OudsListItemIndicatorPrevious;
    final showNextIndicator =
        widget.onTap != null &&
        widget.indicator is! OudsListItemIndicatorPrevious;

    final verticalPadding = _verticalPadding(tokens);

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: tokens.sizeMinWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MergeSemantics groups all row children into one a11y node —
          // matches Android's `semantics(mergeDescendants = true)`.
          MergeSemantics(
            child: Semantics(
              button: widget.onTap != null,
              enabled: widget.enable,
              child: GestureDetector(
                onTap: widget.enable ? widget.onTap : null,
                child: Container(
                  color: OudsListItemBackgroundModifier(
                    context,
                  ).getBackgroundColor(state, decoration),
                  constraints: BoxConstraints(minHeight: _minHeight(tokens)),
                  padding: EdgeInsets.only(
                    top: verticalPadding.top,
                    bottom: verticalPadding.bottom,
                    left: tokens.spacePaddingInline,
                    right: tokens.spacePaddingInline,
                  ),
                  child: Row(
                    crossAxisAlignment: _rowCrossAxisAlignment(),
                    children: [
                      // Previous indicator — chevron at the start of the row.
                      if (showPreviousIndicator) ...[
                        _buildIndicator(context, state, oudsTheme.packageName),
                        SizedBox(width: tokens.spaceColumnGap),
                      ],

                      // Leading slot.
                      if (widget.leading != null) ...[
                        _buildLeading(
                          context,
                          widget.leading!,
                          enable: widget.enable,
                        ),
                        SizedBox(width: tokens.spaceColumnGap),
                      ],

                      // Content column — expands to fill remaining space.
                      Expanded(
                        child: _buildContent(
                          context,
                          typography,
                          contentColor,
                          mutedColor,
                        ),
                      ),

                      // Trailing slot.
                      if (widget.trailing != null) ...[
                        SizedBox(width: tokens.spaceColumnGap),
                        _buildTrailing(
                          context,
                          widget.trailing!,
                          enable: widget.enable,
                        ),
                      ],

                      // Next / External indicator — icon at the end of the row.
                      if (showNextIndicator) ...[
                        SizedBox(width: tokens.spaceColumnGap),
                        _buildIndicator(context, state, oudsTheme.packageName),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Divider drawn outside MergeSemantics so it is not announced.
          if (widget.divider) OudsDivider.horizontal(),

          // Helper text below the divider.
          if (widget.helperText != null && widget.helperText!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                top: tokens.spacePaddingBlockTopHelperText,
                left: tokens.spacePaddingInline,
                right: tokens.spacePaddingInline,
              ),
              child: Text(
                widget.helperText!,
                style: typography
                    .typeLabelDefaultMedium(context)
                    .copyWith(color: mutedColor),
              ),
            ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Leading builder
  // -------------------------------------------------------------------------

  /// Converts an [OudsListItemLeading] data object into its rendered widget.
  static Widget _buildLeading(
    BuildContext context,
    OudsListItemLeading leading, {
    required bool enable,
  }) {
    return switch (leading) {
      OudsListItemLeadingIcon(:final iconStatus, :final size, :final tinted) =>
        OudsListItemAssetBuilder.buildIcon(
          context,
          iconStatus,
          enable: enable,
          size: size.assetSize,
          tinted: tinted,
        ),
      OudsListItemLeadingImage(:final asset, :final size, :final format) =>
        OudsListItemAssetBuilder.buildImage(
          context,
          asset,
          size.assetSize,
          format,
        ),
      OudsListItemLeadingFlag(:final asset) =>
        OudsListItemAssetBuilder.buildFlag(context, asset),
      OudsListItemLeadingVideo() =>
        OudsListItemAssetBuilder.buildVideoPlaceholder(context, enable: enable),
      OudsListItemLeadingAvatar(:final avatar) => avatar,
      OudsListItemLeadingText(:final label, :final extraLabel, :final style) =>
        _buildLeadingText(context, label, extraLabel, style, enable),
      OudsListItemLeadingCustom(:final builder) => builder(
        context,
        enable: enable,
      ),
    };
  }

  /// Renders the text-leading variant (label + optional extra-label).
  static Widget _buildLeadingText(
    BuildContext context,
    String label,
    String? extraLabel,
    OudsListItemTextStyle style,
    bool enable,
  ) {
    final typography = OudsTheme.of(context).typographyTokens;
    final foreground = OudsListItemForegroundModifier(context);

    // Muted style uses a secondary color; all others use the primary content color.
    final color = style == OudsListItemTextStyle.labelMuted
        ? foreground.mutedColor(enable)
        : foreground.contentColor(enable);

    final textStyle = switch (style) {
      OudsListItemTextStyle.label || OudsListItemTextStyle.labelMuted =>
        typography.typeLabelDefaultLarge(context),
      OudsListItemTextStyle.labelStrong => typography.typeLabelStrongLarge(
        context,
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle.copyWith(color: color)),
        if (extraLabel != null)
          Text(
            extraLabel,
            style: typography
                .typeLabelStrongLarge(context)
                .copyWith(color: foreground.contentColor(enable)),
          ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Trailing builder
  // -------------------------------------------------------------------------

  /// Converts an [OudsListItemTrailing] data object into its rendered widget.
  static Widget _buildTrailing(
    BuildContext context,
    OudsListItemTrailing trailing, {
    required bool enable,
  }) {
    return switch (trailing) {
      OudsListItemTrailingText(:final textType) => _buildTrailingText(
        context,
        textType,
        enable,
      ),
      OudsListItemTrailingBadge(:final badge) => badge(enable),
      OudsListItemTrailingTag(:final tag) => tag(enable),
      OudsListItemTrailingIcon(:final icon, :final size, :final tinted) =>
        OudsListItemAssetBuilder.buildIcon(
          context,
          icon,
          enable: enable,
          size: size.assetSize,
          tinted: tinted,
        ),
      OudsListItemTrailingImage(:final asset, :final size, :final format) =>
        OudsListItemAssetBuilder.buildImage(
          context,
          asset,
          size.assetSize,
          format,
        ),
      OudsListItemTrailingFlag(:final asset) =>
        OudsListItemAssetBuilder.buildFlag(context, asset),
      OudsListItemTrailingVideo() =>
        OudsListItemAssetBuilder.buildVideoPlaceholder(context, enable: enable),
      OudsListItemTrailingAvatar(:final avatar) => avatar,
      OudsListItemTrailingCustom(:final builder) => builder(
        context,
        enable: enable,
      ),
    };
  }

  /// Renders the text-trailing variant — delegates to the [OudsListItemTrailingTextType] switch.
  static Widget _buildTrailingText(
    BuildContext context,
    OudsListItemTrailingTextType textType,
    bool enable,
  ) {
    final typography = OudsTheme.of(context).typographyTokens;
    final foreground = OudsListItemForegroundModifier(context);
    final contentColor = foreground.contentColor(enable);
    final mutedColor = foreground.mutedColor(enable);

    return switch (textType) {
      OudsListItemTrailingLabel(:final text) => Text(
        text,
        style: typography
            .typeLabelDefaultMedium(context)
            .copyWith(color: contentColor),
      ),
      OudsListItemTrailingLabelMuted(:final text) => Text(
        text,
        style: typography
            .typeLabelDefaultMedium(context)
            .copyWith(color: mutedColor),
      ),
      OudsListItemTrailingLabelStrong(:final text) => Text(
        text,
        style: typography
            .typeLabelStrongMedium(context)
            .copyWith(color: contentColor),
      ),
      OudsListItemTrailingLabelAndExtraLabel(:final text, :final extraLabel) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: typography
                  .typeLabelDefaultMedium(context)
                  .copyWith(color: contentColor),
            ),
            Text(
              extraLabel,
              style: typography
                  .typeLabelStrongMedium(context)
                  .copyWith(color: contentColor),
            ),
          ],
        ),
    };
  }

  // -------------------------------------------------------------------------
  // Navigation indicator
  // -------------------------------------------------------------------------

  /// Builds the navigation indicator (chevron or external-link icon).
  ///
  /// When [enable] is `false`, the indicator uses [contentDisabled] so it
  /// remains visible (just dimmed) — instead of the potentially transparent
  /// [actionDisabled] color.
  Widget _buildIndicator(
    BuildContext context,
    OudsListItemControlState state,
    String packageName,
  ) {
    const size = OudsListItemAssetSize.small;

    return switch (widget.indicator) {
      OudsListItemIndicatorNext() =>
        OudsListItemAssetBuilder.buildIndicatorIcon(
          context,
          AppAssets.icons.componentLinkNext,
          size,
          state,
          packageName,
          enable: widget.enable,
        ),
      OudsListItemIndicatorPrevious() =>
        OudsListItemAssetBuilder.buildIndicatorIcon(
          context,
          AppAssets.icons.componentLinkPrevious,
          size,
          state,
          packageName,
          enable: widget.enable,
        ),
      OudsListItemIndicatorExternal() => Icon(
        Icons.open_in_new,
        size: size.value(context),
        color: widget.enable
            ? OudsListItemIndicatorModifier(context).indicatorColor(state)
            : OudsTheme.of(context).colorScheme(context).contentDisabled,
      ),
    };
  }

  // -------------------------------------------------------------------------
  // Content column
  // -------------------------------------------------------------------------

  Widget _buildContent(
    BuildContext context,
    OudsTypography typography,
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
            style: typography
                .typeLabelModerateSmall(context)
                .copyWith(color: mutedColor),
          ),
        Text(
          widget.label,
          style:
              (widget.boldLabel
                      ? typography.typeLabelStrongLarge(context)
                      : typography.typeLabelDefaultLarge(context))
                  .copyWith(color: contentColor),
        ),
        if (widget.extraLabel != null && widget.extraLabel!.isNotEmpty)
          Text(
            widget.extraLabel!,
            style: typography
                .typeLabelStrongMedium(context)
                .copyWith(color: contentColor),
          ),
        if (widget.description != null && widget.description!.isNotEmpty)
          Text(
            widget.description!,
            style: typography
                .typeLabelDefaultMedium(context)
                .copyWith(color: mutedColor),
          ),
      ],
    );
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

  /// Computes vertical padding for the row.
  ///
  /// When [contentAlignment] is [top], a counterweight token is used so the
  /// leading/trailing assets align visually with the first line of text.
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
