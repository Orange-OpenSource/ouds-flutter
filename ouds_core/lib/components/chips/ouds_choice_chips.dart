//
// Software Name: OUDS Flutter
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Software description: Flutter library of reusable graphical components
//

import 'package:flutter/material.dart';
import 'package:ouds_core/components/chips/ouds_chip_common.dart';

/// OUDS Design Choice Chips.
///
/// Displays a customizable chips with an optional action.
///
class OudsChoiceChip extends StatelessWidget {
  /// Creates an OUDS Choice Chip.
  /// Creates an OUDS Choice Chip.
  ///
  /// * [text] - Text to be displayed into the chip
  /// * [onClick] - Callback called on chip click.
  /// * [enabled] - The action to be executed when the chips is pressed.
  /// * [leadingAvatar] - Widget of the icon.
  /// * [selected] - Specifies whether the chips is selected or not.
  ///
  const OudsChoiceChip({
    super.key,
    required this.text,
    this.onClick,
    this.enabled = true,
    this.selected = false,
    this.leadingAvatar,
  });

  /// Text to be displayed into the chip.
  final String text;

  /// Callback called on chip click
  final void Function(bool?)? onClick;

  /// Specifies whether the chips is selected or not.
  final bool enabled;

  /// Specifies whether the chips is selected or not.
  final bool selected;

  /// The optional chip's icon.
  final OudsChipLeadingAvatar? leadingAvatar;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Semantics(
        child: Text(text),
      ),
      onSelected: enabled != false ? onClick : null,
      selected: selected,
      avatar: leadingAvatar,
    );
  }
}
