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
import 'package:flutter/services.dart';
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

/// [OUDS List Item Design Guidelines](https://r.orange.fr/r/S-ouds-doc-list-item)
///
/// **Reference design version : 1.0.0**
///
/// List item is a UI element that displays a row of information within a list.
/// It mirrors Flutter's [ListTile] spirit — leading / label / trailing — but uses
/// OUDS design tokens, interaction states and an optional navigation indicator.
///
/// A list item can be static (read-only) or interactive (navigation). The item
/// adapts its visual appearance according to hover, pressed and disabled states.
///
/// ---
/// ## Variants
///
/// - **Static** — no [onTap], displays read-only information. No interaction states.
/// - **Navigation** — provide [onTap] to make the item interactive. The entire item
///   acts as a single link target and supports the following interaction states:
///   - **Enabled** — default state; the item is available for navigation.
///   - **Hover** — visual feedback when a pointer is over the item. Does not
///     move content, change dimensions, or reveal hidden information.
///   - **Focus** — keyboard focus indicator drawn around the complete navigation
///     target (background + border ring via [actionSupportFocus] / [actionFocus]).
///   - **Pressed** — temporary state while the item is being activated, applied
///     to the entire navigation target.
///
/// ---
/// ## Parameters
///
/// - [label]: The mandatory main text displayed in the center column.
/// - [size]: Size variant ([OudsListItemSize.defaultSize] or [OudsListItemSize.smallSize]).
/// - [contentAlignment]: Vertical alignment of all slots within the row ([OudsListItemContentAlignment]).
/// - [overline]: Optional text displayed above [label] in a smaller, muted style.
/// - [extraLabel]: Optional strong label displayed between [label] and [description].
/// - [description]: Optional secondary text displayed below [label] / [extraLabel].
/// - [leading]: Optional content at the start of the row (icon, image, avatar, flag …).
/// - [trailing]: Optional content at the end of the row (icon, image, text, badge, tag …).
/// - [divider]: Whether a horizontal divider is drawn below the item. Defaults to `true`.
/// - [background]: Whether the item has a persistent background color. Defaults to `false`.
///   Set to `true` for static items — matches the Android default for [OudsSmallListItem].
/// - [helperText]: Optional helper text displayed below the row (and below the divider).
/// - [boldLabel]: Whether [label] is rendered in bold. Defaults to `false`.
/// - [enable]: Whether the item is interactive. When `false`, all content is rendered
///   in its disabled appearance and [onTap] is ignored. Defaults to `true`.
/// - [onTap]: Callback invoked when the item is tapped. When non-null the item becomes
///   a **navigation item** — it gains an [indicator] chevron and forwards taps.
/// - [indicator]: Navigation indicator shown when [onTap] is provided.
///   Defaults to [OudsListItemDefaults.indicator] (chevron pointing right).
///
/// ### Usage Example
///
/// ```dart
/// // Static list item with a leading icon
/// OudsListItem(
///   label: 'Title',
///   description: 'Secondary text',
///   leading: OudsListItemLeadingIcon(Neutral(icon: 'assets/icons/star.svg')),
///   background: true,
/// );
///
/// // Navigation list item (chevron displayed automatically)
/// OudsListItem(
///   label: 'Navigate',
///   onTap: () => Navigator.of(context).push(…),
/// );
///
/// // List item with overline, extra label and trailing text
/// OudsListItem(
///   label: 'Main label',
///   overline: 'Category',
///   extraLabel: 'Strong info',
///   description: 'Additional detail',
///   trailing: OudsListItemTrailingText(
///     OudsListItemTrailingLabel(text: '99€'),
///   ),
/// );
///
/// // Disabled list item
/// OudsListItem(
///   label: 'Unavailable',
///   enable: false,
/// );
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
  // Local interaction states — updated by MouseRegion, GestureDetector and
  // FocusNode so that hover/pressed/focused appearance is applied without
  // relying on a parent OudsInheritedInteractionModel.
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() => _isFocused = _focusNode.hasFocus);

  /// Whether this item is interactive (has a tap callback and is enabled).
  bool get _isInteractive => widget.enable && widget.onTap != null;

  void _onEnter(_) => setState(() => _isHovered = true);
  void _onExit(_) => setState(() => _isHovered = false);

  void _onTapDown(_) {
    if (_isInteractive) {
      setState(() => _isPressed = true);
      HapticFeedback.lightImpact();
    }
  }

  void _onTapUp(_) => setState(() => _isPressed = false);
  void _onTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final oudsTheme = OudsTheme.of(context);
    final tokens = oudsTheme.componentsTokens(context).listItem;
    final typography = oudsTheme.typographyTokens;
    final colorScheme = oudsTheme.colorScheme(context);

    // Map background + onTap flags to the correct decoration type:
    // - background=true               → persistent background in all states
    // - background=false + onTap≠null → background visible only on interaction
    //                                   (hover / pressed / focused)
    // - background=false + onTap=null → no background ever (static/read-only item)
    final decoration = widget.background
        ? OudsListItemDecorationBackground(divider: widget.divider)
        : widget.onTap != null
        ? OudsListItemDecorationBackgroundOnInteraction(divider: widget.divider)
        : OudsListItemDecorationNone(divider: widget.divider);

    // Resolve the interaction state from local hover/pressed/focused tracking.
    // Disabled takes priority over everything else.
    final state = OudsListItemControlStateDeterminer(
      enabled: widget.enable,
      isPressed: _isPressed,
      isHovered: _isHovered,
      isFocused: _isFocused,
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
              child: Focus(
                focusNode: _focusNode,
                // Skip focus entirely for non-interactive items.
                canRequestFocus: _isInteractive,
                onKeyEvent: (_, event) {
                  if (!_isInteractive) return KeyEventResult.ignored;
                  if (event is KeyDownEvent &&
                      (event.logicalKey == LogicalKeyboardKey.enter ||
                          event.logicalKey == LogicalKeyboardKey.space)) {
                    widget.onTap?.call();
                    HapticFeedback.lightImpact();
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: MouseRegion(
                  // Track hover only for interactive items — no cursor change on static items.
                  cursor: _isInteractive
                      ? SystemMouseCursors.click
                      : MouseCursor.defer,
                  onEnter: _isInteractive ? _onEnter : null,
                  onExit: _isInteractive ? _onExit : null,
                  child: GestureDetector(
                    onTap: widget.enable ? widget.onTap : null,
                    onTapDown: _isInteractive ? _onTapDown : null,
                    onTapUp: _isInteractive ? _onTapUp : null,
                    onTapCancel: _isInteractive ? _onTapCancel : null,
                    child: Container(
                      // Use BoxDecoration to support both the background color
                      // and the focus ring (border) simultaneously.
                      // The focus ring is drawn around the complete navigation
                      // target as required by the OUDS spec.
                      decoration: BoxDecoration(
                        color: OudsListItemBackgroundModifier(
                          context,
                        ).getBackgroundColor(state, decoration),
                        border: _isFocused && _isInteractive
                            ? Border.all(
                                color: colorScheme.actionFocus,
                                width: tokens.borderWidthDefault,
                              )
                            : null,
                        borderRadius: _isFocused && _isInteractive
                            ? BorderRadius.circular(tokens.borderRadiusDefault)
                            : null,
                      ),
                      constraints: BoxConstraints(
                        minHeight: _minHeight(tokens),
                      ),
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
                            _buildIndicator(
                              context,
                              state,
                              oudsTheme.packageName,
                            ),
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
                            _buildIndicator(
                              context,
                              state,
                              oudsTheme.packageName,
                            ),
                          ],
                        ],
                      ), // Row
                    ), // Container
                  ), // GestureDetector
                ), // MouseRegion
              ), // Focus
            ), // Semantics
          ), // MergeSemantics
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

  // Helper methods for layout (used by build)

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

  // -------------------------------------------------------------------------
  // Leading builder
  // -------------------------------------------------------------------------

  /// Converts an [OudsListItemLeading] data object into its rendered widget.
  ///
  /// Handles icons (with dynamic size), images (with format support), flags,
  /// videos (placeholder), avatars and custom builders.
  /// Respects the [enable] state for color opacity adjustments.
  static Widget _buildLeading(
    BuildContext context,
    OudsListItemLeading leading, {
    required bool enable,
  }) {
    return switch (leading) {
      OudsListItemLeadingIcon(:final iconStatus, :final size, :final tinted) =>
        // Icon container: dynamic size based on icon size
        _buildIconContainer(
          context,
          OudsListItemAssetBuilder.buildIcon(
            context,
            iconStatus,
            enable: enable,
            size: size.assetSize,
            tinted: tinted,
          ),
          size.assetSize,
        ),
      OudsListItemLeadingImage(
        :final asset,
        :final size,
        :final format,
        :final rounded,
      ) =>
        // Image container: dynamic dimensions based on size and format
        _buildImageContainer(
          context,
          OudsListItemAssetBuilder.buildImage(
            context,
            asset,
            size.assetSize,
            format,
            rounded: rounded,
          ),
          size,
          format,
        ),
      // Flag container: width is hardcoded (no sizeFlagWidth token available),
      // height comes from the sizeFlagHeight token.
      OudsListItemLeadingFlag(:final flag) => SizedBox(
        width: 26.8,
        height: OudsTheme.of(
          context,
        ).componentsTokens(context).listItem.sizeFlagHeight,
        child: flag,
      ),
      OudsListItemLeadingVideo() =>
        // Video container: dimensions from sizeAssetSmall token.
        _buildVideoContainer(context, enable: enable),
      // Avatar, text, custom: flexible container
      OudsListItemLeadingAvatar(:final avatar) => avatar,
      OudsListItemLeadingText(:final label, :final extraLabel, :final style) =>
        _buildLeadingText(context, label, extraLabel, style, enable),
      OudsListItemLeadingCustom(:final builder) => builder(
        context,
        enable: enable,
      ),
    };
  }

  /// Builds an image container with dimensions based on size and format.
  static Widget _buildImageContainer(
    BuildContext context,
    Widget image,
    OudsListItemImageSize size,
    OudsListItemImageFormat format,
  ) {
    final tokens = OudsTheme.of(context).componentsTokens(context).listItem;
    final minHeight = tokens.sizeAssetMedium;

    final double width;
    final double height;

    if (format == OudsListItemImageFormat.square) {
      // Square format (1:1): both sides from the corresponding size token.
      final side = size.assetSize.value(context);
      width = side;
      height = side;
    } else {
      // Panoramic format (16:9): height fixed to the large asset token,
      // width computed from the 16:9 ratio.
      height = OudsListItemAssetSize.large.value(context);
      width = height * OudsListItemImageFormat.panoramic.ratio;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: SizedBox(width: width, height: height, child: image),
    );
  }

  /// Builds an icon container with dimensions based on icon size.
  static Widget _buildIconContainer(
    BuildContext context,
    Widget icon,
    OudsListItemAssetSize size,
  ) {
    // Icon container uses token-defined dimensions
    final dimension = size.value(context);
    return SizedBox(width: dimension, height: dimension, child: icon);
  }

  /// Builds the video placeholder container.
  ///
  /// Uses [OudsListItemAssetSize.small] token to size the container — consistent
  /// with how other small assets are sized inside list items.
  static Widget _buildVideoContainer(
    BuildContext context, {
    required bool enable,
  }) {
    final dimension = OudsListItemAssetSize.small.value(context);
    return SizedBox(
      width: dimension,
      height: dimension,
      child: OudsListItemAssetBuilder.buildVideoPlaceholder(
        context,
        enable: enable,
      ),
    );
  }

  /// Renders the text-leading variant (label + optional extra-label).
  ///
  /// Applies muted color for [OudsListItemTextStyle.labelMuted], else uses
  /// the primary content color. Respects the [enable] state.
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
    final color = switch (style) {
      OudsListItemTextStyle.labelMuted => foreground.mutedColor(enable),
      OudsListItemTextStyle.label ||
      OudsListItemTextStyle.labelStrong => foreground.contentColor(enable),
    };

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
  ///
  /// Handles text variants (label, muted, strong), badges, tags, icons,
  /// images, flags, videos (placeholder), avatars and custom builders.
  /// Respects the [enable] state for color opacity adjustments.
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
        // Icon container: dynamic size based on icon size
        _buildIconContainer(
          context,
          OudsListItemAssetBuilder.buildIcon(
            context,
            icon,
            enable: enable,
            size: size.assetSize,
            tinted: tinted,
          ),
          size.assetSize,
        ),
      OudsListItemTrailingImage(
        :final asset,
        :final size,
        :final format,
        :final rounded,
      ) =>
        // Image container: dynamic dimensions based on size and format
        _buildImageContainer(
          context,
          OudsListItemAssetBuilder.buildImage(
            context,
            asset,
            size.assetSize,
            format,
            rounded: rounded,
          ),
          size,
          format,
        ),
      // Flag container: width is hardcoded (no sizeFlagWidth token available),
      // height comes from the sizeFlagHeight token.
      OudsListItemTrailingFlag(:final flag) => SizedBox(
        width: 26.8,
        height: OudsTheme.of(
          context,
        ).componentsTokens(context).listItem.sizeFlagHeight,
        child: flag,
      ),
      OudsListItemTrailingVideo() => _buildVideoContainer(
        context,
        enable: enable,
      ),
      OudsListItemTrailingAvatar(:final avatar) => avatar,
      OudsListItemTrailingCustom(:final builder) => builder(
        context,
        enable: enable,
      ),
    };
  }

  /// Renders the text-trailing variant — handles all [OudsListItemTrailingTextType] combinations.
  ///
  /// Maps text style (label, muted, strong) to appropriate colors and typography.
  /// Handles single and double-line text layouts (label + extraLabel).
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
  /// [actionDisabled] color. Resolves the correct asset based on the indicator type.
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

  /// Renders the center content column with overline, label, extra-label and description.
  ///
  /// Applies typography and colors from tokens. Respects [boldLabel] to use
  /// strong typography. Uses [contentColor] for labels and [mutedColor] for
  /// overline and description.
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
}
