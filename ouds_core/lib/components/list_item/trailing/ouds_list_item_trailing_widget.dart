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
import 'package:ouds_core/components/list_item/trailing/ouds_list_item_trailing.dart';

class OudsListItemTrailingWidget extends StatelessWidget {
  final OudsListItemTrailing trailing;

  const OudsListItemTrailingWidget({super.key, required this.trailing});

  @override
  Widget build(BuildContext context) {
    // Construisez ici le widget trailing selon vos besoins
    return Text("data"); // ou une logique spécifique
  }
}
