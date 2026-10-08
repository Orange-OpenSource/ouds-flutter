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

/// [OUDS Card Item Design Guidelines](https://r.orange.fr/r/S-ouds-doc-list-item)
///
/// **Reference design version : 1.0.0**
///
/// A compact card-formatted variant of [OudsCardItem].
///
/// Compared to [OudsCardItem], this variant omits [overline] and [extraLabel]
/// and reuses the restricted leading / trailing model from [OudsSmallListItem],
/// while applying the card decoration defaults.
///
/// It reuses the same horizontal padding as [OudsSmallListItem].
///
/// - [leading] accepts [OudsSmallListItemLeadingIcon] or
///   [OudsSmallListItemLeadingImage].
/// - [trailing] accepts [OudsSmallListItemTrailingIcon],
///   [OudsSmallListItemTrailingImage] or [OudsSmallListItemTrailingText].
///
/// ### Usage Example
///
/// ```dart
/// OudsSmallCardItem(
///   label: 'Messagerie',
///   description: '3 notifications',
///   leading: OudsSmallListItemLeadingIcon(Info()),
/// )
///
/// OudsSmallCardItem(
///   label: 'Paiement',
///   trailing: OudsSmallListItemTrailingText('99€'),
///   onTap: () {},
/// )
/// ```
class OudsSmallCardItem extends StatelessWidget {
  /// The mandatory main label displayed in the center column.
  final String label;

  /// Vertical alignment of all slots.
  final OudsListItemContentAlignment contentAlignment;

  /// Visual decoration of the card. Defaults to a persistent background.
  final OudsListItemDecoration decoration;

  /// Optional secondary text displayed below [label].
  final String? description;

  /// Optional leading content.
  final OudsSmallListItemLeading? leading;

  /// Optional trailing content.
  final OudsSmallListItemTrailing? trailing;

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
    );
  }
}
