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
import 'package:ouds_core/components/list_item/ouds_card_item.dart';
import 'package:ouds_core/components/list_item/ouds_list_item.dart';
import 'package:ouds_core/components/list_item/ouds_small_list_item.dart';
import 'package:ouds_core/components/skeleton/ouds_skeleton.dart';

/// [OUDS Small Card Item Design Guidelines](https://r.orange.fr/r/S-ouds-doc-list-item)
///
/// **Reference design version : 0.4.0**
///
/// A compact card-formatted variant of [OudsCardItem].
///
/// Compared to [OudsCardItem], this variant omits `overline` and `extraLabel`
/// and reuses the restricted leading / trailing model from [OudsSmallListItem],
/// while applying the card decoration defaults.
///
/// It always uses the grid margin for its horizontal padding, like an
/// edge-to-edge [OudsSmallListItem].
///
/// Standard text fields use [OudsListItemText] for text and optional colors.
/// See its documentation for supported emphasis and segment color precedence.
///
/// - [leading] accepts [OudsSmallListItemLeadingIcon] or
///   [OudsSmallListItemLeadingImage].
/// - [trailing] accepts [OudsSmallListItemTrailingIcon],
///   [OudsSmallListItemTrailingImage], [OudsSmallListItemTrailingText],
///   [OudsSmallListItemTrailingBadge] or [OudsSmallListItemTrailingTag].
///
/// ### Usage Example
///
/// ```dart
/// OudsSmallCardItem(
///   label: OudsListItemText(text: 'Messagerie'),
///   description: OudsListItemText(text: '3 notifications'),
///   leading: OudsSmallListItemLeadingIcon(Info()),
/// )
///
/// OudsSmallCardItem(
///   label: OudsListItemText(text: 'Paiement'),
///   trailing: OudsSmallListItemTrailingText('99€'),
///   onTap: () {},
/// )
///
/// // Small card with an image loaded from the network and a custom
/// // placeholder shown while loading (and if loading fails)
/// OudsSmallCardItem(
///   label: OudsListItemText(text: 'Product'),
///   leading: OudsSmallListItemLeadingImage.provider(
///     provider: NetworkImage('https://example.com/photo.jpg'),
///     semanticsLabel: 'Product photo',
///     placeholder: Image.asset('assets/placeholder.jpg'),
///   ),
/// )
/// ```
class OudsSmallCardItem extends StatelessWidget {
  /// The mandatory main label displayed in the center column.
  final OudsListItemText label;

  /// Vertical alignment of all slots.
  final OudsListItemContentAlignment contentAlignment;

  /// Visual decoration of the card. Defaults to
  /// [OudsCardItemDefaults.decoration] (persistent background with a bottom
  /// divider). Pass `OudsListItemDecorationBackground(divider: false)` to keep
  /// the background without the divider.
  final OudsListItemDecoration decoration;

  /// Optional secondary text displayed below [label].
  final OudsListItemText? description;

  /// Optional leading content.
  final OudsSmallListItemLeading? leading;

  /// Optional trailing content.
  final OudsSmallListItemTrailing? trailing;

  /// Optional helper text displayed below the row.
  ///
  /// Supports strong emphasis; field and segment colors are ignored in favor
  /// of the default muted color.
  final OudsListItemText? helperText;

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

  /// Creates a compact OUDS card item.
  const OudsSmallCardItem({
    super.key,
    required this.label,
    this.contentAlignment = OudsCardItemDefaults.contentAlignment,
    this.decoration = OudsCardItemDefaults.decoration,
    this.description,
    this.leading,
    this.trailing,
    this.helperText,
    this.boldLabel = false,
    this.enable = true,
    this.onTap,
    this.indicator = OudsCardItemDefaults.indicator,
    this.skeleton,
  });

  @override
  Widget build(BuildContext context) {
    return OudsSmallListItem(
      label: label,
      contentAlignment: contentAlignment,
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
      skeleton: skeleton,
    );
  }
}
