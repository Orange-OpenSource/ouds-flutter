/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_action_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_always_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_border_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_content_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_decorative_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_opacity_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_overlay_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_repository_semantic_tokens.dart';
import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_surface_semantic_tokens.dart';

class OudsColorSemanticTokens {
  final OudsColorActionSemanticTokens actionColorTokens;
  final OudsColorAlwaysSemanticTokens alwaysColorTokens;
  final OudsColorBgSemanticTokens backgroundColorTokens;
  final OudsColorBorderSemanticTokens borderColorTokens;
  final OudsColorContentSemanticTokens contentColorTokens;
  final OudsColorDecorativeSemanticTokens decorativeColorTokens;
  final OudsColorOpacitySemanticTokens opacityColorTokens;
  final OudsColorOverlaySemanticTokens overlayColorTokens;
  final OudsColorSurfaceSemanticTokens surfaceColorTokens;
  final OudsColorRepositorySemanticTokens repositoryColorTokens;

  const OudsColorSemanticTokens({
    required this.actionColorTokens,
    required this.alwaysColorTokens,
    required this.backgroundColorTokens,
    required this.borderColorTokens,
    required this.contentColorTokens,
    required this.decorativeColorTokens,
    required this.opacityColorTokens,
    required this.overlayColorTokens,
    required this.surfaceColorTokens,
    required this.repositoryColorTokens,
  });
}
