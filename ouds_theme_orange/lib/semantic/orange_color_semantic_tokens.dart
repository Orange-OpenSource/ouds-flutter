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

import 'package:ouds_theme_contract/theme/tokens/semantic/ouds_color_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_action_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_always_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_border_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_content_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_decorative_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_opacity_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_overlay_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_repository_semantic_tokens.dart';
import 'package:ouds_theme_orange/semantic/orange_color_surface_semantic_tokens.dart';

class OrangeColorSemanticTokens extends OudsColorSemanticTokens {
  const OrangeColorSemanticTokens({
    OrangeColorActionSemanticTokens actionColorTokens =
        const OrangeColorActionSemanticTokens(),
    OrangeColorAlwaysSemanticTokens alwaysColorTokens =
        const OrangeColorAlwaysSemanticTokens(),
    OrangeColorBgSemanticTokens backgroundColorTokens =
        const OrangeColorBgSemanticTokens(),
    OrangeColorBorderSemanticTokens borderColorTokens =
        const OrangeColorBorderSemanticTokens(),
    OrangeColorContentSemanticTokens contentColorTokens =
        const OrangeColorContentSemanticTokens(),
    OrangeColorDecorativeSemanticTokens decorativeColorTokens =
        const OrangeColorDecorativeSemanticTokens(),
    OrangeColorOpacitySemanticTokens opacityColorTokens =
        const OrangeColorOpacitySemanticTokens(),
    OrangeColorOverlaySemanticTokens overlayColorTokens =
        const OrangeColorOverlaySemanticTokens(),
    OrangeColorSurfaceSemanticTokens surfaceColorTokens =
        const OrangeColorSurfaceSemanticTokens(),
    OrangeColorRepositorySemanticTokens repositoryColorTokens =
        const OrangeColorRepositorySemanticTokens(),
  }) : super(
          actionColorTokens: actionColorTokens,
          alwaysColorTokens: alwaysColorTokens,
          backgroundColorTokens: backgroundColorTokens,
          borderColorTokens: borderColorTokens,
          contentColorTokens: contentColorTokens,
          decorativeColorTokens: decorativeColorTokens,
          opacityColorTokens: opacityColorTokens,
          overlayColorTokens: overlayColorTokens,
          surfaceColorTokens: surfaceColorTokens,
          repositoryColorTokens: repositoryColorTokens,
        );

  @override
  OrangeColorActionSemanticTokens get actionColorTokens =>
      const OrangeColorActionSemanticTokens();

  @override
  OrangeColorAlwaysSemanticTokens get alwaysColorTokens =>
      const OrangeColorAlwaysSemanticTokens();

  @override
  OrangeColorBgSemanticTokens get backgroundColorTokens =>
      const OrangeColorBgSemanticTokens();

  @override
  OrangeColorBorderSemanticTokens get borderColorTokens =>
      const OrangeColorBorderSemanticTokens();

  @override
  OrangeColorContentSemanticTokens get contentColorTokens =>
      const OrangeColorContentSemanticTokens();

  @override
  OrangeColorDecorativeSemanticTokens get decorativeColorTokens =>
      const OrangeColorDecorativeSemanticTokens();

  @override
  OrangeColorOpacitySemanticTokens get opacityColorTokens =>
      const OrangeColorOpacitySemanticTokens();

  @override
  OrangeColorOverlaySemanticTokens get overlayColorTokens =>
      const OrangeColorOverlaySemanticTokens();

  @override
  OrangeColorSurfaceSemanticTokens get surfaceColorTokens =>
      const OrangeColorSurfaceSemanticTokens();

  @override
  OrangeColorRepositorySemanticTokens get repositoryColorTokens =>
      const OrangeColorRepositorySemanticTokens();
}
