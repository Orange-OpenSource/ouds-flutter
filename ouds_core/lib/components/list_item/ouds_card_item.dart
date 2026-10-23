/*
 * // Software Name: OUDS Flutter
 * // SPDX-FileCopyrightText: Copyright (c) Orange SA
 * // SPDX-License-Identifier: MIT
 *
 * // This software is distributed under the MIT license,
 * // the text of which is available at https://opensource.org/license/MIT/
 * // or see the "LICENSE" file for more details.
 *
 * // Software description: Flutter library of reusable graphical components
 *
 */

/// {@category Card item}
library;

import 'package:flutter/material.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_state.dart';
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';

/// Default values for [OudsCardItem].
class OudsCardItemDefaults {
  OudsCardItemDefaults._();

  /// Default content alignment.
  static const contentAlignment = OudsListItemDefaults.contentAlignment;

  /// Default navigation indicator.
  static const OudsListItemIndicator indicator = OudsListItemIndicatorNext();

  /// Default decoration — a persistent background with a bottom divider.
  static const OudsListItemDecoration decoration =
      OudsListItemDecorationBackground();
}

/// [OUDS Card Item Design Guidelines](https://r.orange.fr/r/S-ouds-doc-static-card-item)
///
/// [OUDS Navigation Card Item Design Guidelines](https://r.orange.fr/r/S-ouds-doc-navigation-card-item)
///
///
/// **Reference design version : 0.3.0**
///
/// A card-formatted variant of [OudsListItem].
///
/// `OudsCardItem` keeps the rich content model of `list item` — overline,
/// label, extra label, description, leading and trailing slots — while applying
/// the card decoration defaults. It is ideal for read-only summaries,
/// grouped content and navigable cards with stronger visual emphasis.
///
/// The component keeps the default list-item density and always uses the grid
/// margin for its horizontal padding, like an edge-to-edge [OudsListItem].
///
/// ### Usage Example
///
/// ```dart
/// OudsCardItem(
///   label: 'Plan 200 Go',
///   overline: 'Mobile',
///   extraLabel: 'Sans engagement',
///   description: '5G en France et en Europe',
///   leading: OudsListItemLeadingIcon(Positive()),
/// )
///
/// OudsCardItem(
///   label: 'Voir le détail',
///   description: 'Ouvre une nouvelle page',
///   onTap: () {},
/// )
///
/// OudsCardItem.labelContent(
///   labelContent: (context, state) => Text('Custom label content'),
///   description: 'Ouvre une nouvelle page',
/// )
///
/// // Card with an image loaded from the network and a custom
/// // placeholder shown while loading (and if loading fails)
/// OudsCardItem(
///   label: 'Product',
///   leading: OudsListItemLeadingImage.provider(
///     provider: NetworkImage('https://example.com/photo.jpg'),
///     semanticsLabel: 'Product photo',
///     placeholder: Image.asset('assets/placeholder.jpg'),
///   ),
/// )
/// ```
class OudsCardItem extends StatelessWidget {
  /// The mandatory main label displayed in the center column.
  ///
  /// Mutually exclusive with [labelContent] — use [OudsCardItem.labelContent]
  /// to provide fully custom content instead of a plain text label.
  final String? label;

  /// Optional fully custom content replacing the plain text [label].
  ///
  /// The builder receives the current [OudsListItemControlState].
  final Widget Function(BuildContext context, OudsListItemControlState state)?
  labelContent;

  /// Vertical alignment of all slots.
  final OudsListItemContentAlignment contentAlignment;

  /// Visual decoration of the card. Defaults to
  /// [OudsCardItemDefaults.decoration] (persistent background with a bottom
  /// divider). Pass `OudsListItemDecorationBackground(divider: false)` to keep
  /// the background without the divider.
  final OudsListItemDecoration decoration;

  /// Optional text displayed above [label] in a smaller, muted style.
  final String? overline;

  /// Optional strong accompanying label displayed between [label] and [description].
  final String? extraLabel;

  /// Optional secondary text displayed below [label] / [extraLabel].
  final String? description;

  /// Optional content at the start of the row.
  final OudsListItemLeading? leading;

  /// Optional content at the end of the row.
  final OudsListItemTrailing? trailing;

  /// Optional fully custom content displayed right after [description], inside
  /// the center text column.
  ///
  /// The builder receives the current [OudsListItemControlState].
  final Widget Function(BuildContext context, OudsListItemControlState state)?
  belowTextContent;

  /// Optional fully custom content displayed below the main row, full-width,
  /// but still inside the item's background/border area.
  ///
  /// The builder receives the current [OudsListItemControlState].
  final Widget Function(BuildContext context, OudsListItemControlState state)?
  bottomContent;

  /// Optional helper text displayed below the row.
  final String? helperText;

  /// Whether [label] is rendered in bold. Defaults to `false`.
  final bool boldLabel;

  /// Whether the item is interactive. Defaults to `true`.
  final bool enable;

  /// Callback invoked when the card is tapped.
  final VoidCallback? onTap;

  /// Navigation indicator shown when [onTap] is provided.
  final OudsListItemIndicator indicator;

  /// An optional skeleton that improves the perceived loading time by providing a visual cue of where the card item will appear once fully loaded.
  final OudsSkeleton? skeleton;

  /// Creates an OUDS card item.
  const OudsCardItem({
    super.key,
    required this.label,
    this.contentAlignment = OudsCardItemDefaults.contentAlignment,
    this.decoration = OudsCardItemDefaults.decoration,
    this.overline,
    this.extraLabel,
    this.description,
    this.belowTextContent,
    this.leading,
    this.trailing,
    this.bottomContent,
    this.helperText,
    this.boldLabel = false,
    this.enable = true,
    this.onTap,
    this.indicator = OudsCardItemDefaults.indicator,
    this.skeleton,
  }) : labelContent = null;

  /// Creates an OUDS card item with fully custom [labelContent] instead of a
  /// plain text label.
  const OudsCardItem.labelContent({
    super.key,
    required this.labelContent,
    this.contentAlignment = OudsCardItemDefaults.contentAlignment,
    this.decoration = OudsCardItemDefaults.decoration,
    this.overline,
    this.extraLabel,
    this.description,
    this.belowTextContent,
    this.leading,
    this.trailing,
    this.bottomContent,
    this.helperText,
    this.boldLabel = false,
    this.enable = true,
    this.onTap,
    this.indicator = OudsCardItemDefaults.indicator,
    this.skeleton,
  }) : label = null;

  @override
  Widget build(BuildContext context) {
    if (labelContent != null) {
      return OudsListItem.labelContent(
        labelContent: labelContent!,
        size: OudsListItemSize.defaultSize,
        contentAlignment: contentAlignment,
        overline: overline,
        extraLabel: extraLabel,
        description: description,
        belowTextContent: belowTextContent,
        leading: leading,
        trailing: trailing,
        bottomContent: bottomContent,
        decoration: decoration,
        helperText: helperText,
        boldLabel: boldLabel,
        enable: enable,
        onTap: onTap,
        indicator: indicator,
        card: true,
        skeleton: skeleton,
      );
    }
    return OudsListItem(
      label: label,
      size: OudsListItemSize.defaultSize,
      contentAlignment: contentAlignment,
      overline: overline,
      extraLabel: extraLabel,
      description: description,
      belowTextContent: belowTextContent,
      leading: leading,
      trailing: trailing,
      bottomContent: bottomContent,
      decoration: decoration,
      helperText: helperText,
      boldLabel: boldLabel,
      enable: enable,
      onTap: onTap,
      indicator: indicator,
      card: true,
      skeleton: skeleton,
    );
  }
}
