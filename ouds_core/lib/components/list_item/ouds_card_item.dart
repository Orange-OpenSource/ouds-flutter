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
import 'package:ouds_core/components/list_item/internal/ouds_list_item_types.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';

/// Default values for [OudsCardItem].
class OudsCardItemDefaults {
  OudsCardItemDefaults._();

  /// Default content alignment.
  static const contentAlignment = OudsListItemDefaults.contentAlignment;

  /// Default navigation indicator.
  static const OudsListItemIndicator indicator = OudsListItemIndicatorNext();

  /// Default decoration — card items always use a background.
  static const OudsListItemDecoration decoration =
      OudsListItemDecorationBackground();
}

/// [OUDS Card Item Design Guidelines](https://r.orange.fr/r/S-ouds-doc-list-item)
///
/// **Reference design version : 1.0.0**
///
/// A card-formatted variant of [OudsListItem].
///
/// `OudsCardItem` keeps the rich content model of `list item` — overline,
/// label, extra label, description, leading and trailing slots — while applying
/// the card decoration defaults. It is ideal for read-only summaries,
/// grouped content and navigable cards with stronger visual emphasis.
///
/// The component keeps the default list-item density and reuses the same
/// horizontal padding as [OudsListItem].
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
/// ```
class OudsCardItem extends StatelessWidget {
  /// The mandatory main label displayed in the center column.
  final String label;

  /// Vertical alignment of all slots.
  final OudsListItemContentAlignment contentAlignment;

  /// Visual decoration of the card. Defaults to a persistent background.
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

  /// Creates an OUDS card item.
  const OudsCardItem({
    super.key,
    required this.label,
    this.contentAlignment = OudsCardItemDefaults.contentAlignment,
    this.decoration = OudsCardItemDefaults.decoration,
    this.overline,
    this.extraLabel,
    this.description,
    this.leading,
    this.trailing,
    this.helperText,
    this.boldLabel = false,
    this.enable = true,
    this.onTap,
    this.indicator = OudsCardItemDefaults.indicator,
  });

  @override
  Widget build(BuildContext context) {
    return OudsListItem(
      label: label,
      size: OudsListItemSize.defaultSize,
      contentAlignment: contentAlignment,
      overline: overline,
      extraLabel: extraLabel,
      description: description,
      leading: leading,
      trailing: trailing,
      decoration: decoration,
      helperText: helperText,
      boldLabel: boldLabel,
      enable: enable,
      onTap: onTap,
      indicator: indicator,
      card: true,
    );
  }
}
