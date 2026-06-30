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
import 'package:ouds_core/components/control/internal/interaction/ouds_inherited_interaction_model.dart';
import 'package:ouds_core/components/divider/ouds_divider.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_background_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_foreground_modifier.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading_widget.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing_widget.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';
import 'package:ouds_theme_contract/theme/scheme/responsive/ouds_size_scheme.dart';
import 'package:ouds_theme_contract/theme/scheme/typography/ouds_typography.dart';
import 'package:ouds_theme_contract/theme/tokens/components/ouds_listItem_tokens.dart';

/// Default values for [OudsListItem].
class OudsListItemDefaults {
  OudsListItemDefaults._();

  /// Default content alignment of an [OudsListItem].
  static const contentAlignment = OudsListItemContentAlignment.center;

  /// Default navigation chevron of an [OudsListItem].
  static const chevron = OudsListItemChevron.next;

  /// Default size of an [OudsListItem].
  static const size = OudsListItemSize.defaultSize;
}

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

/// Represents the navigation chevron of an [OudsListItem].
enum OudsListItemChevron {
  /// Used in a standard navigation context. This chevron is positioned at the
  /// end of the list item and is not customizable.
  next,

  /// Used for "backward" navigation. This chevron is positioned at the start of
  /// the list item and is not customizable.
  previous,
}

/// A list item component that displays a row of information within a list.
///
/// Supports leading and trailing slots, multiple text lines (overline, label,
/// extra label, description), divider, background, bold label, and enable/disable state.
///
/// Example:
/// ```dart
/// OudsListItem(
///   label: 'Title',
///   description: 'Secondary text',
///   leading: OudsListItemLeadingIcon(Neutral()),
/// )
/// ```
class OudsListItem extends StatefulWidget {
  final String label;
  final OudsListItemSize size;
  final OudsListItemContentAlignment contentAlignment;
  final String? overline;
  final String? extraLabel;
  final String? description;
  final OudsListItemLeading? leading;
  final OudsListItemTrailing? trailing;
  final bool divider;
  final bool background;
  final String? helperText;
  final bool boldLabel;
  final bool enable;

  const OudsListItem({
    super.key,
    required this.label,
    this.size = OudsListItemDefaults.size,
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
    final listItemBackgroundModifier = OudsListItemBackgroundModifier(context);
    final listItemForegroundModifier = OudsListItemForegroundModifier(context);
    final typographyTokens = oudsTheme.typographyTokens;
    final listItemTokens = oudsTheme.componentsTokens(context).listItem;
    final sizeToken = oudsTheme.sizeScheme(context);
    final listItemStateDeterminer = OudsListItemControlStateDeterminer(
      enabled: widget.enable,
      isPressed: isPressed,
      isHovered: isHovered,
    );
    final listItemState = listItemStateDeterminer.determineControlState();
    final contentColor = listItemForegroundModifier.contentColor(widget.enable);
    final mutedColor = listItemForegroundModifier.mutedColor(widget.enable);

    return Column(
      children: [
        Container(
          color: listItemBackgroundModifier.getBackgroundColor(
            listItemState,
            widget.background,
          ),
          constraints: BoxConstraints(
            minHeight: widget.size == OudsListItemSize.smallSize
                ? listItemTokens.sizeMinHeightSmall
                : listItemTokens.sizeMinHeightDefault,
          ),
          padding: EdgeInsets.symmetric(
            vertical: widget.size == OudsListItemSize.smallSize
                ? listItemTokens.spacePaddingBlockSmall
                : listItemTokens.spacePaddingBlockDefault,
            horizontal: listItemTokens.spacePaddingInline,
          ),
          child: Row(
            crossAxisAlignment: _getRowCrossAxisAlignment(),
            children: [
              if (widget.leading != null) ...[_buildLeading(listItemTokens)],
              _buildContent(
                context,
                typographyTokens,
                contentColor,
                mutedColor,
                sizeToken,
              ),
              if (widget.trailing != null) ...[_buildTrailing(listItemTokens)],
            ],
          ),
        ),
        if (widget.divider) _buildDivider(),
      ],
    );
  }

  /// Builds the leading widget followed by a horizontal gap.
  /// Displayed to the left of the main content — can be an icon, image or avatar.
  Widget _buildLeading(OudsListItemTokens listItemTokens) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      OudsListItemLeadingWidget(leading: widget.leading!, enable: widget.enable),
      SizedBox(width: listItemTokens.spaceColumnGap),
    ],
  );

  /// Builds the main content area (center column) that takes all available
  /// horizontal space. Renders in order: overline → label → extraLabel → description.
  Widget _buildContent(
    BuildContext context,
    OudsTypography typographyTokens,
    Color contentColor,
    Color mutedColor,
    OudsSizeScheme sizeToken,
  ) => Expanded(
    child: Column(
      mainAxisAlignment: _getContentMainAxisAlignment(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.overline != null)
          _buildOverline(context, typographyTokens, mutedColor, sizeToken),
        _buildLabel(context, typographyTokens, contentColor, sizeToken),
        if (widget.extraLabel != null)
          _buildExtraLabel(context, typographyTokens, contentColor, sizeToken),
        if (widget.description != null)
          _buildDescription(context, typographyTokens, mutedColor, sizeToken),
      ],
    ),
  );

  MainAxisAlignment _getContentMainAxisAlignment() {
    return switch (widget.contentAlignment) {
      OudsListItemContentAlignment.center => MainAxisAlignment.center,
      OudsListItemContentAlignment.top => MainAxisAlignment.start,
    };
  }

  CrossAxisAlignment _getRowCrossAxisAlignment() {
    return switch (widget.contentAlignment) {
      OudsListItemContentAlignment.center => CrossAxisAlignment.center,
      OudsListItemContentAlignment.top => CrossAxisAlignment.start,
    };
  }

  /// Returns the label text style based on [OudsListItem.boldLabel].
  /// Uses [OudsTypography.typeLabelStrongLarge] when bold, [OudsTypography.typeLabelDefaultLarge] otherwise.
  TextStyle _labelStyle(
    BuildContext context,
    OudsTypography typographyTokens,
    Color color,
  ) =>
      (widget.boldLabel
              ? typographyTokens.typeLabelStrongLarge(context)
              : typographyTokens.typeLabelDefaultLarge(context))
          .copyWith(color: color);

  /// Builds the main label of the list item.
  /// Always displayed, constrained to [OudsSizeScheme.maxWidthLabelLarge].
  Widget _buildLabel(
    BuildContext context,
    OudsTypography typographyTokens,
    Color color,
    OudsSizeScheme sizeToken,
  ) => ConstrainedBox(
    constraints: BoxConstraints(maxWidth: sizeToken.maxWidthLabelLarge),
    child: Text(
      widget.label,
      style: _labelStyle(context, typographyTokens, color),
    ),
  );

  /// Builds the overline text displayed above the main label.
  /// Uses a small muted style, constrained to [OudsSizeScheme.maxWidthLabelSmall].
  Widget _buildOverline(
    BuildContext context,
    OudsTypography typographyTokens,
    Color color,
    OudsSizeScheme sizeToken,
  ) => ConstrainedBox(
    constraints: BoxConstraints(maxWidth: sizeToken.maxWidthLabelSmall),
    child: Text(
      widget.overline!,
      style: typographyTokens
          .typeLabelModerateSmall(context)
          .copyWith(color: color),
    ),
  );

  /// Builds the extra label displayed below the main label.
  /// Uses a bold style to highlight an important secondary piece of information.
  Widget _buildExtraLabel(
    BuildContext context,
    OudsTypography typographyTokens,
    Color color,
    OudsSizeScheme sizeToken,
  ) => ConstrainedBox(
    constraints: BoxConstraints(maxWidth: sizeToken.maxWidthLabelMedium),
    child: Text(
      widget.extraLabel!,
      style: typographyTokens
          .typeLabelStrongMedium(context)
          .copyWith(color: color),
    ),
  );

  /// Builds the description text displayed at the bottom of the content area.
  /// Uses a muted style to indicate secondary information.
  Widget _buildDescription(
    BuildContext context,
    OudsTypography typographyTokens,
    Color color,
    OudsSizeScheme sizeToken,
  ) => ConstrainedBox(
    constraints: BoxConstraints(maxWidth: sizeToken.maxWidthLabelMedium),
    child: Text(
      widget.description!,
      style: typographyTokens
          .typeLabelDefaultMedium(context)
          .copyWith(color: color),
    ),
  );

  /// Builds the trailing widget preceded by a horizontal gap.
  /// Displayed to the right of the content — can be an icon, button or value.
  Widget _buildTrailing(OudsListItemTokens listItemTokens) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(width: listItemTokens.spaceColumnGap),
      OudsListItemTrailingWidget(trailing: widget.trailing!, enable: widget.enable),
    ],
  );

  /// Builds the horizontal divider displayed below the list item.
  /// Only visible when [OudsListItem.divider] is `true`.
  Widget _buildDivider() => OudsDivider.horizontal();
}
