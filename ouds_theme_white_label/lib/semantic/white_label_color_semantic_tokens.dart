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
import 'package:ouds_theme_white_label/semantic/white_label_color_action_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_always_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_bg_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_border_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_content_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_decorative_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_opacity_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_overlay_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_repository_semantic_tokens.dart';
import 'package:ouds_theme_white_label/semantic/white_label_color_surface_semantic_tokens.dart';

class WhiteLabelColorSemanticTokens extends OudsColorSemanticTokens {
  const WhiteLabelColorSemanticTokens({
    WhiteLabelColorActionSemanticTokens actionColorTokens =
        const WhiteLabelColorActionSemanticTokens(),
    WhiteLabelColorAlwaysSemanticTokens alwaysColorTokens =
        const WhiteLabelColorAlwaysSemanticTokens(),
    WhiteLabelColorBgSemanticTokens backgroundColorTokens =
        const WhiteLabelColorBgSemanticTokens(),
    WhiteLabelColorBorderSemanticTokens borderColorTokens =
        const WhiteLabelColorBorderSemanticTokens(),
    WhiteLabelColorContentSemanticTokens contentColorTokens =
        const WhiteLabelColorContentSemanticTokens(),
    WhiteLabelColorDecorativeSemanticTokens decorativeColorTokens =
        const WhiteLabelColorDecorativeSemanticTokens(),
    WhiteLabelColorOpacitySemanticTokens opacityColorTokens =
        const WhiteLabelColorOpacitySemanticTokens(),
    WhiteLabelColorOverlaySemanticTokens overlayColorTokens =
        const WhiteLabelColorOverlaySemanticTokens(),
    WhiteLabelColorSurfaceSemanticTokens surfaceColorTokens =
        const WhiteLabelColorSurfaceSemanticTokens(),
    WhiteLabelColorRepositorySemanticTokens repositoryColorTokens =
        const WhiteLabelColorRepositorySemanticTokens(),
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

  // Utilisation de getters pour ne pas redéfinir les champs hérités

  @override
  WhiteLabelColorActionSemanticTokens get actionColorTokens =>
      const WhiteLabelColorActionSemanticTokens();

  @override
  WhiteLabelColorAlwaysSemanticTokens get alwaysColorTokens =>
      const WhiteLabelColorAlwaysSemanticTokens();

  @override
  WhiteLabelColorBgSemanticTokens get backgroundColorTokens =>
      const WhiteLabelColorBgSemanticTokens();

  @override
  WhiteLabelColorBorderSemanticTokens get borderColorTokens =>
      const WhiteLabelColorBorderSemanticTokens();

  @override
  WhiteLabelColorContentSemanticTokens get contentColorTokens =>
      const WhiteLabelColorContentSemanticTokens();

  @override
  WhiteLabelColorDecorativeSemanticTokens get decorativeColorTokens =>
      const WhiteLabelColorDecorativeSemanticTokens();

  @override
  WhiteLabelColorOpacitySemanticTokens get opacityColorTokens =>
      const WhiteLabelColorOpacitySemanticTokens();

  @override
  WhiteLabelColorOverlaySemanticTokens get overlayColorTokens =>
      const WhiteLabelColorOverlaySemanticTokens();

  @override
  WhiteLabelColorSurfaceSemanticTokens get surfaceColorTokens =>
      const WhiteLabelColorSurfaceSemanticTokens();

  @override
  WhiteLabelColorRepositorySemanticTokens get repositoryColorTokens =>
      const WhiteLabelColorRepositorySemanticTokens();
}
