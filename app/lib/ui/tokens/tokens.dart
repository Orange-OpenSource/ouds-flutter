/*
 * Software Name : Orange Design System
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:flutter/material.dart';
import 'package:ouds_flutter_demo/l10n/app_localizations.dart';
import 'package:ouds_flutter_demo/ui/tokens/elevation/elevation_screen.dart';
import 'package:ouds_flutter_demo/ui/tokens/token_entities.dart';
import 'package:ouds_flutter_demo/ui/utilities/adaptive_image_helper.dart';

import 'color/color_screen.dart';

List<Token> tokens(BuildContext context) {
  return [
    Token(
      context.l10n.app_tokens_elevation_label,
      AdaptiveImageHelper.getImage(context, 'assets/il_elevation.png'),
      AppLocalizations.of(context)!.app_tokens_elevation_description_text,
      const ElevationScreen(),
    ),
    Token(
      context.l10n.app_tokens_color_label,
      AdaptiveImageHelper.getImage(context, 'assets/il_color.png'),
      AppLocalizations.of(context)!.app_tokens_color_description_text,
      const ColorScreen(),
    ),
  ];
}
