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
import 'package:ouds_core/components/button/internal/button_background_modifier.dart';
import 'package:ouds_core/components/button/internal/button_border_modifier.dart';
import 'package:ouds_core/components/button/internal/button_foreground_modifier.dart';
import 'package:ouds_core/components/button/internal/button_padding_modifier.dart';
import 'package:ouds_core/components/button/ouds_button.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_size_modifier.dart';
import 'package:ouds_core/components/tag/internal/ouds_tag_status_modifier.dart';
import 'package:ouds_core/components/tag/ouds_tag.dart';
import 'package:ouds_theme_contract/ouds_theme.dart';

class OudsTagStyleModifier {

  final BuildContext context;

  OudsTagStyleModifier(this.context);

   TextStyle buildTagTextStyle(
    BuildContext context, {
    required OudsTagHierarchy hierarchy,
    required OudsTagStatus status,
    required OudsTagSize size,
  }) {
   return size == OudsTagSize.defaultSize?
   OudsTheme.of(context).typographyTokens.typeLabelStrongMedium(context).copyWith(
     color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(status, hierarchy),
   )
       : OudsTheme.of(context).typographyTokens.typeLabelStrongSmall(context).copyWith(
     color: OudsTagStatusModifier(context).getStatusTextAndLoaderColor(status, hierarchy) ,
   );

  }
}
