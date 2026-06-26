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

import 'package:flutter/material.dart';
import 'package:ouds_core/components/list_item/leading/ouds_list_item_leading.dart';

class OudsListItemLeadingWidget extends StatelessWidget {
  final OudsListItemLeading leading;
  final bool enable;

  const OudsListItemLeadingWidget({
    super.key,
    required this.leading,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return leading.toWidget(context, enable: enable);
  }
}
